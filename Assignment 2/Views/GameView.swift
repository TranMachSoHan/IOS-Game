/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 09/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://www.pinterest.com/imabamfyo/game-ui-splash-welcome-screens/
    https://stackoverflow.com/questions/56443535/swiftui-text-alignment
    https://www.pinterest.com/pin/451134087689536109/
    https://www.pinterest.com/pin/701154235755448104/
    https://www.besthdwallpaper.com/cuoi-lon/knight-zed-splash-art-lien-minh-huyen-thoai-lol-dt_vi-64746.html
    https://www.freepik.com/premium-photo/scary-black-werewolf-illustration-full-body-3d-rendering_33092555.htm
    https://betterprogramming.pub/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
*/


import SwiftUI

var emptyCharacter : Character = Character()
struct GameView: View {
    @EnvironmentObject var gameSettings: GameSettings
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var dataController: DataController
    @State var draggedCharacter: Character = emptyCharacter
    @ObservedObject var gameStatus: GameStatus
    @EnvironmentObject var viewRouter: ViewRouter
    @State var victoryState: Bool = false
    @State var pauseGame: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack{
                        pauseButton
                        Spacer()
                        gameProgressNoti
                    }
                    .frame(height: geo.size.height/10)

                    PlayerStatusView(
                        image: gameStatus.botPlayer.image,
                        bloodPoint: $gameStatus.botPlayer.bloodPoint,
                        manaPoint: $gameStatus.botPlayer.manaPoint,
                        manaPositionTop: false,
                        showDeck: false,
                        draggedCharacter: $draggedCharacter,
                        player: $gameStatus.botPlayer,
                        playerTurn: $gameStatus.playerTurn,
                        displayCharacterDeck: $gameStatus.botPlayer.displayCharacterDeck,
                        showLoading: true,
                        gameStatus: gameStatus
                    ).frame(height: geo.size.height/5)
                    
                    BoardCell(draggedCharacter: $draggedCharacter, gameStatus: gameStatus)
                        .frame(height: geo.size.height/10)
                    
                    PlayerStatusView(
                        image: gameStatus.mainPlayer.image,
                        bloodPoint: $gameStatus.mainPlayer.bloodPoint,
                        manaPoint: $gameStatus.mainPlayer.manaPoint,
                        manaPositionTop: true,
                        showDeck: true,
                        draggedCharacter: $draggedCharacter,
                        player: $gameStatus.mainPlayer,
                        playerTurn: $gameStatus.playerTurn,
                        displayCharacterDeck: $gameStatus.mainPlayer.displayCharacterDeck,
                        showLoading: false,
                        gameStatus: gameStatus
                    )
                    
                }
                .onChange(of: self.gameStatus.playerTurn, perform: { (value) in
                    if self.gameStatus.playerTurn == self.gameStatus.botPlayer{
                        self.gameStatus.botLoading()
                    }
                })
                .onChange(of: self.gameStatus.victory, perform: { (value) in
                    if self.gameStatus.victory{
                        let level = gameSettings.level + 1
                        let mode = gameSettings.difficultyMode
                        // Update core data and Current Player
                        currentPlayer.easyLevel = mode == .easy ? level : currentPlayer.easyLevel
                        currentPlayer.mediumLevel = mode == .medium ? level : currentPlayer.mediumLevel
                        currentPlayer.hardLevel = mode == .hard ? level : currentPlayer.hardLevel
                        dataController.updatePlayerLevel(level: level, mode: mode, id: UUID(uuidString: currentPlayer.id) ?? UUID(), context: managedObjContext)
                        self.gameStatus.victory = false
                        victoryState = true
                    }
                    
                    
                })
                if pauseGame {
                    PauseView(pauseGame: $pauseGame)
                }
            }
        }
        .popover(isPresented: $victoryState) {
            //Show winning announcement view with no swipe down action
            GameAnnouncementView(isWon: true)
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $gameStatus.gameOver){
            //Show game over announcement view with no swipe down action
            GameAnnouncementView(isWon: false)
                .interactiveDismissDisabled()
        }
    }
}

extension GameView {
    var gameProgressNoti: some View {
        VStack{
            Text("Level \(gameSettings.level)")
                .modifier(HeadingModifier())
            Text("Mode \(gameSettings.difficultyMode.rawValue)")
                .modifier(HeadingModifier())
        }
    }
    
    var pauseButton: some View {
        Button(action: {
           pauseGame = true
        }) {
            Image(systemName: "pause.circle")
                .modifier(HeadingModifier())
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameStatus: GameStatus())
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(DataController())
            .environmentObject(CurrentPlayer())
            .environmentObject(ViewRouter())
            .environmentObject(GameSettings())
    }
}
