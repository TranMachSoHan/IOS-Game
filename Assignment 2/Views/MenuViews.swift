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

    var body: some View {
        GeometryReader { geo in
            ZStack {
                //Background
                Image("welcome-background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                Spacer()
                VStack(alignment: .center) {
                    //Game Title
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height/13, alignment: .center)
                        .padding(.top,100)
                    
                    //Header: Greeting current player
                    Text("Welcome \(currentPlayer.name)")
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                        .frame(alignment: .center)
                        .padding(.top,80)
                    
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .gamePage
                        }
                    }) {
                        Image("play-btn")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                            .shadow(color: .red, radius: 5, x: 5, y: 5)
                    }
                    
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .switchUser
                        }
                    }) {
                        Image("play-btn")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/1.2, height: geo.size.height/10)
                            .shadow(color: .red, radius: 5, x: 5, y: 5)
                    }
                    
                    Button(action: {
//                        viewRouter.currentPage = .switchUser
                    }) {
                            Image("how-to-play-btn")
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
                        Image("setting-btn")
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
                        Image("leaderboard")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width/5, height: geo.size.height/5)
                            
                    }
                    Spacer()
                }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            }
        }
//        //Start the menu play music and loop
//        .onAppear(perform: {
//            playSound(sound: "backgroundMusic", type: "wav")
//            audioPlayer?.numberOfLoops = 100
//        })
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
    }
}
