/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 18/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import SwiftUI

// This shows the Game Announcement when user wins or lose game
struct GameAnnouncementView: View {
    @EnvironmentObject var gameSettings: GameSettings
    @State var isWon: Bool = false
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .center){
                gameSettings.menuTheme.topLevelColor
                VStack {
                    Text(isWon ? "Congratulations" : "Game Over")
                        .foregroundColor(gameSettings.menuTheme.fourthLevelColor)
                        .bold()
                        .font(Font.system(size: geo.size.width/8))
                    
                    HStack{
                        // Back to level selection btn
                        backBtn
                        // Continue level or re-try btn
                        gamePlayBtn
                    }
                    .frame(height:geo.size.height/6)
                    .padding(.horizontal, geo.size.width/15)
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
        .onAppear(){
            // Play sound effect
            if isWon{
                MusicPlayer.shared.playSoundEffect(soundEffect: "level-up", type: "wav")
            }
            else{
                MusicPlayer.shared.playSoundEffect(soundEffect: "game-over", type: "wav")
            }
            /**
             Remove from gameSettings
            **/
            gameSettings.gameProgress = nil
        }
    }
}

extension GameAnnouncementView{
    // Back to level view
    var backBtn: some View {
        GeometryReader { geo in
            Button {
                viewRouter.currentPage = .gameLevelPage
            } label: {
                Capsule()
                    .fill(gameSettings.menuTheme.secondLevelColor)
                    .padding(.vertical, geo.size.width/15)
                    
                    .overlay(
                        Text("Back")
                            .font(.system(size: geo.size.width/8, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(gameSettings.menuTheme.fourthLevelColor)
                    )
            }
        }
    }
    
    // Continue level or re-try btn
    var gamePlayBtn: some View {
        GeometryReader { geo in
            Button {
                if isWon {
                    gameSettings.level = gameSettings.level + 1
                }
                viewRouter.currentPage = .gameLevelPage
                viewRouter.currentPage = .gamePage
            } label: {
                Capsule()
                    .fill(gameSettings.menuTheme.thirdLevelColor)
                    .padding(.vertical, geo.size.width/15)
                    .overlay(
                        Text(isWon ? "Next Level ?" : "Retry ?")
                            .font(.system(size: geo.size.width/8, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(gameSettings.menuTheme.topLevelColor)
                    )
            }
        }
    }
}

struct GameAnnouncementView_Previews: PreviewProvider {
    static var previews: some View {
        GameAnnouncementView(isWon: true)
            .environmentObject(GameSettings())
            .environmentObject(ViewRouter())
    }
}
