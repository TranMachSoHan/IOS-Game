/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 07/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://www.pinterest.com/imabamfyo/game-ui-splash-welcome-screens/
    https://stackoverflow.com/questions/56443535/swiftui-text-alignment
*/

import Foundation
import SwiftUI

struct MenuView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer : CurrentPlayer
    @EnvironmentObject var gameSettings : GameSettings
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .center){
                //Background
                
                Image(gameSettings.menuTheme.menuBackgroundImage)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                Spacer()
                VStack(alignment: .center) {
                    //Game Title
                    Image(gameSettings.darkMode ? "logo-dark": "logo-light")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height/13, alignment: .center)
                        .padding(.top,100)
                    
                    //Header: Greeting current player
                    HStack{
                        Text("Welcome")
                            .modifier(HeadingModifier())
                        Text("\(currentPlayer.name)")
                            .modifier(HeadingModifier())
                            .underline()
                            .onTapGesture {
                                withAnimation {
                                    viewRouter.currentPage = .switchUser
                                }
                            }
                    }
                    .padding(.top,80)
                    
                    
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .gameLevelPage
                        }
                    }) {
                        Image(gameSettings.darkMode ? "play-btn-dark": "play-btn-light")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                        
                    }
                    
                    Button(action: {
//                        viewRouter.currentPage = .switchUser
                    }) {
                            Image(gameSettings.darkMode ? "how-to-play-btn-dark": "how-to-play-btn-light")
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                                .shadow(color: .red, radius: 5, x: 5, y: 5)
                        }
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .profilePage
                        }
                    }) {
                        Image(gameSettings.darkMode ? "setting-btn-dark": "setting-btn-light")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                            .shadow(color: .red, radius: 5, x: 5, y: 5)
                    }
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .leaderboardPage
                        }
                    }) {
                        Image(gameSettings.darkMode ? "leaderboard-dark": "leaderboard-light")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/5, height: geo.size.height/5)
                            
                    }
                    Spacer()
                }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            }
        }
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
            .environmentObject(GameSettings())
    }
}
