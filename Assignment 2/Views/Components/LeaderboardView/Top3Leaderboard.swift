/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 23/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
 https://adrianhall.github.io/swift/2020/05/03/swiftui-masks/
 
*/

import SwiftUI
struct Top3Leaderboard: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Button(action: {
                    withAnimation {
                        viewRouter.currentPage = .menuPage
                    }}) {
                        Text("< Go Back")
                            .underline()
                    }
                Spacer()
            }
            Text("Leaderboard")
                .foregroundColor(Color.red)
                .font(.system(size: 50))
                .fontWeight(.bold)
        }
        .frame(height: 300)
        .background(Color.blue)
        .mask(CustomShape(radius: 25))
        .shadow(color: .gray, radius: 5, x: 0, y: 5)
        .edgesIgnoringSafeArea(.top)
    }
}
