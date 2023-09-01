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
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack {
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
                    )
                    .frame(height: geo.size.height/6)
                    
                    BoardCell(draggedCharacter: $draggedCharacter, gameStatus: gameStatus)
                        
                    
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
                    .frame(height: geo.size.height/2.5)
                }
            }
            .onChange(of: self.gameStatus.playerTurn, perform: { (value) in
                if self.gameStatus.playerTurn == self.gameStatus.botPlayer{
                    self.gameStatus.botLoading()
                }
            })
            .padding(.top, 30)
        }
        .popover(isPresented: $gameStatus.victory) {
            //Show winning announcement view with no swipe down action
            GameAnnouncementView(isWon: true)
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $gameStatus.gameOver){
            //Show game over announcement view with no swipe down action
            GameAnnouncementView(isWon: false)
                .interactiveDismissDisabled()
        }
//        .sheet(isPresented: $showPopUpBadge) {
//            EarnNewBadgeView(badge: findBadgeByName(name: "New Member"), showPopUpBadge: $showPopUpBadge)
//        }
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
