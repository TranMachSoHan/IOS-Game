/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 07/08/2023
  Last modified: 02/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var gameSettings: GameSettings
    @State var showPopUpBadge: Bool = false
    
    var body: some View {
        ZStack {
            ZStack{
                gameSettings.menuTheme.topLevelColor
                //Display the corresponding view based on the varible
                switch viewRouter.currentPage {
                    case .menuPage:
                        MenuView()
                    case .gamePage:
                        GameView(gameStatus: GameStatus(level: gameSettings.level, mode: gameSettings.difficultyMode))
                    case .gameLevelPage:
                        LevelView()
                    case .switchUser:
                        SwitchUserView()
                    case .leaderboardPage:
                        LeaderboardView()
                    case .howToPlayPage:
                        MenuView()
                    case .profilePage:
                        ProfileView()
                    }
            }.padding(.top, 50)
            
        }.onAppear{
            let player = dataController.getPlayerById(with: UUID(uuidString: currentPlayer.id), context: managedObjContext)
            if (player == nil){
                viewRouter.currentPage = .switchUser
            }
            else{
                currentPlayer.setPlayer(player: player ?? Player(context: managedObjContext))
            }
            MusicPlayer.shared.startBackgroundMusic(backgroundMusicFileName: "background-music")
        }
        .onChange(of: viewRouter.currentPage) { newState in
            if viewRouter.currentPage == .gamePage{
                MusicPlayer.shared.audioPlayer?.setVolume(0.5, fadeDuration: 0.5)
            }
            else{
                MusicPlayer.shared.audioPlayer?.setVolume(1, fadeDuration: 1)
            }
        }
        .onChange(of: gameSettings.badgeNameUnlock) { newState in
            if gameSettings.badgeNameUnlock != ""{
                dataController.addBadgeForPlayer(
                    badgeName: gameSettings.badgeNameUnlock,
                    id: UUID(uuidString: currentPlayer.id) ?? UUID(),
                    context: managedObjContext)
                currentPlayer.badges.append(gameSettings.badgeNameUnlock)
                showPopUpBadge = true
            }
        }
        .sheet(isPresented: $showPopUpBadge) {
            EarnNewBadgeView(badge: findBadgeByName(name: gameSettings.badgeNameUnlock), showPopUpBadge: $showPopUpBadge)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
            .environmentObject(GameSettings())
            .environmentObject(DataController())
    }
}
