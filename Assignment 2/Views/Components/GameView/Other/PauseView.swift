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

struct PauseView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var gameSettings: GameSettings
    @Binding var pauseGame: Bool
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .center){
                Color.black.opacity(0.5)
                ZStack{
                    VStack {
                        Text("Game Pause")
                            .foregroundColor(gameSettings.menuTheme.fourthLevelColor)
                            .bold()
                            .font(Font.system(size: geo.size.width/8))
                        
                        HStack{
                            // restart game
                            restartButton
                            // unpause game
                            resumeButton
                        }
                        .frame(height:geo.size.height/6)
                        .padding(.horizontal, geo.size.width/15)
                        
                        HStack{
                            // Back to menu page
                            homeButton
                            // Back to level page
                            levelButton
                        }
                        .frame(height:geo.size.height/10)
                        .padding(.horizontal, geo.size.width/5)
                    }
                }
                
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

extension PauseView {
    var restartButton: some View {
        GeometryReader { geo in
            Button {
                viewRouter.currentPage = .gamePage
            } label: {
                Capsule()
                    .fill(gameSettings.menuTheme.thirdLevelColor)
                    .padding(.vertical, geo.size.width/15)
                    .overlay(
                        Text("Restart")
                            .font(.system(size: geo.size.width/8, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(gameSettings.menuTheme.topLevelColor)
                    )
            }
        }
    }
    
    var resumeButton: some View {
        GeometryReader { geo in
            Button {
                pauseGame = false
            } label: {
                Capsule()
                    .fill(gameSettings.menuTheme.thirdLevelColor)
                    .padding(.vertical, geo.size.width/15)
                    .overlay(
                        Text("Resume")
                            .font(.system(size: geo.size.width/8, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(gameSettings.menuTheme.topLevelColor)
                    )
            }
        }
    }
    
    var homeButton: some View {
        GeometryReader { geo in
            Button {
                viewRouter.currentPage = .menuPage
            } label: {
                Capsule()
                    .fill(.clear)
                    .padding(.vertical, geo.size.width/8)
                    .overlay(
                        Image(systemName: "house.circle")
                            .font(.system(size: geo.size.width/3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(gameSettings.menuTheme.thirdLevelColor)
                    )
            }
        }
    }
    
    var levelButton: some View {
        GeometryReader { geo in
            Button {
                viewRouter.currentPage = .gameLevelPage
            } label: {
                Capsule()
                    .fill(.clear)
                    .padding(.vertical, geo.size.width/8)
                    .overlay(
                        Image(systemName: "list.number")
                            .font(.system(size: geo.size.width/3, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(gameSettings.menuTheme.thirdLevelColor)
                    )
            }
        }
    }
    
}
struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView(pauseGame: .constant(true))
            .environmentObject(ViewRouter())
            .environmentObject(GameSettings())
    }
}
