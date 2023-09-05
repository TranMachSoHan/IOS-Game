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
    @State var isNewGame: Bool
    
    init(isNewGame: Bool, gameStatus: GameStatus){
        self.gameStatus = gameStatus
        self.isNewGame = isNewGame
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack{
                        pauseButton
                        Spacer()
                        gameProgressNoti
                        Spacer()
                        showPlayerTurn
                    }

                    PlayerStatusView(
                        image: gameStatus.botPlayer.image,
                        bloodPoint: $gameStatus.botPlayer.bloodPoint,
                        manaPoint: $gameStatus.botPlayer.manaPoint,
                        player: $gameStatus.botPlayer,
                        playerTurn: $gameStatus.playerTurn,
                        isMainPlayerTurn: $gameStatus.isMainPlayerTurn,
                        showLoading: true,
                        gameStatus: gameStatus
                    ).frame(height: geo.size.height/7)
                    
                    BoardCell(draggedCharacter: $draggedCharacter, gameStatus: gameStatus)
                        .frame(height: geo.size.height/10)
                    
                    PlayerStatusView(
                        image: gameStatus.mainPlayer.image,
                        bloodPoint: $gameStatus.mainPlayer.bloodPoint,
                        manaPoint: $gameStatus.mainPlayer.manaPoint,
                        player: $gameStatus.mainPlayer,
                        playerTurn: $gameStatus.playerTurn,
                        isMainPlayerTurn: $gameStatus.isMainPlayerTurn,
                        showLoading: false,
                        gameStatus: gameStatus
                    ).frame(height: geo.size.height/7)
                    CharacterDecksView(
                        draggedCharacter: $draggedCharacter,
                        displayCharacterDeck: $gameStatus.mainPlayer.displayCharacterDeck,
                        playerTurn: $gameStatus.playerTurn,
                        player: $gameStatus.mainPlayer)
                    .frame(height: geo.size.height/7)
                }
                .onChange(of: self.gameStatus.playerTurn, perform: { (value) in
                    if self.gameStatus.playerTurn.id == self.gameStatus.botPlayer.id{
                        self.gameStatus.botLoading()
                    }
                    else{
                        self.gameStatus.isMainPlayerTurn = true
                    }
                    gameStatus.storeGameStatusToMemory(playerId: currentPlayer.id)
                })
                .onChange(of: self.gameStatus.victory, perform: { (value) in
                    if self.gameStatus.victory{
                        let level = self.gameStatus.level + 1
                        let mode = self.gameStatus.mode
                        
                        // Update core data and Current Player
                        currentPlayer.saveLevelUnlock(level: level, mode: mode)
                        dataController.updatePlayerLevel(level: level, mode: mode, id: UUID(uuidString: currentPlayer.id)!, context: managedObjContext)
                        
                        // Toggle pop up sheet victory 
                        self.gameStatus.victory = false
                        victoryState = true
                    }
                })
                .onDisappear(){
                    gameSettings.gameProgress = gameStatus.gameProgress
                }
                
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
    
    var showPlayerTurn: some View{
        ZStack{
            Text("\(gameStatus.showPlayerTurn)")
                .modifier(HeadingModifier())
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isNewGame: true, gameStatus: GameStatus(gameProgress: GameProgress()))
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(DataController())
            .environmentObject(CurrentPlayer())
            .environmentObject(ViewRouter())
            .environmentObject(GameSettings())
    }
}
