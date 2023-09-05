/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 20/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import SwiftUI

struct ProfileView : View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @EnvironmentObject var gameSettings: GameSettings
    
    var body : some View {
        ZStack (alignment: .topLeading){
            ZStack{
                TabView {
                    
                    ProfileAchievementView(imageName: currentPlayer.imageName, name: currentPlayer.name, badges: currentPlayer.badges, backPage: .menuPage)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                            .modifier(HeadingModifier())
                        Text("Profile")
                            .modifier(HeadingModifier())
                    }
                    .tag(0)
                    
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gear.circle.fill")
                                .modifier(HeadingModifier())
                            Text("Setting")
                                .modifier(HeadingModifier())
                        }
                        .tag(0)
                }
                
            }
            Button(action: {
                withAnimation {
                    viewRouter.currentPage = .menuPage
                }}) {
                    Text("< Go Back")
                        .underline()
                }
                .padding(.top, 50)
                .padding(.horizontal, 30)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
            .environmentObject(GameSettings())
    }
}
