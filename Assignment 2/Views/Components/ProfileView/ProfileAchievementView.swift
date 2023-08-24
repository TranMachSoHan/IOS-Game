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

struct ProfileAchievementView : View {
    @EnvironmentObject var viewRouter: ViewRouter
    var imageName: String
    var name: String
    var badges: [String]
    var backPage: Page
    
    var body : some View {
        ZStack (alignment: .top){
            VStack (alignment: .trailing){
                HStack{
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = backPage
                        }}) {
                            Text("< Go Back")
                                .underline()
                        }
                    Spacer()
                }
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(.white),lineWidth: 2))
                        .padding(.vertical, 5)
                    
                    Text(name)
                        .font(.title)
                }
                .frame(height: 200)
                Divider()
                    .frame(minHeight: 1)
                AcheivementBadgeView(playerBadges: badges)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}