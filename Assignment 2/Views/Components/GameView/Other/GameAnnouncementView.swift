//
//  AnnouncementView.swift
//  Assignment 2
//
//  Created by macOS on 01/09/2023.
//


import SwiftUI

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
                        gamePlayBtn
                    }
                    .frame(height:geo.size.height/6)
                    .padding(.horizontal, geo.size.width/15)
                    
                    

                    // Continue level or re-try btn
                    
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
        .onAppear(){
            if isWon{
                MusicPlayer.shared.playSoundEffect(soundEffect: "level-up", type: "wav")
            }
            else{
                MusicPlayer.shared.playSoundEffect(soundEffect: "game-over", type: "wav")
            }
        }
    }
}

extension GameAnnouncementView{
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
    
    var gamePlayBtn: some View {
        GeometryReader { geo in
            Button {
                if isWon {
                    gameSettings.level = gameSettings.level + 1
                }
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
