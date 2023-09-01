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

struct EarnNewBadgeView: View {
    var badge: Badge
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showPopUpBadge: Bool
    
    var body: some View {
        ZStack {
            Image("earn-badge-congrats")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                Button(action: {showPopUpBadge = false}){
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(size: 50,
                                      weight: .bold,
                                      design: .rounded))
                        .foregroundStyle(.gray.opacity(0.4))
                        .padding(8)
                }
                
                Text("You've earned a new badge!")
                    .foregroundColor(.black)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                    .bold()
                
                badge.image
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                
                Text(badge.name)
                    .foregroundColor(.black)
                    .font(.title)
                    .bold()
                
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue.opacity(0.6))
                    .frame(width: 200, height: 50)
                    .overlay {
                        HStack {
                            Text("+ \(badge.score)")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .multilineTextAlignment(.center)
                                .bold()
                            Text("POINTS")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .multilineTextAlignment(.center)
                        }
                        
                    }
                Divider()
                    .frame(minHeight: 1)
                
                Button(action: {
                    viewRouter.currentPage = .leaderboardPage
                }) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.blue)
                        .frame(width: 350, height: 50)
                        .overlay {
                            Text("VIEW YOUR BADGES")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        }
                }
                
                Button(action: {
                    viewRouter.currentPage = .leaderboardPage
                }) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.blue)
                        .frame(width: 350, height: 50)
                        .overlay {
                            Text("VIEW THE LEADERBOARD")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .multilineTextAlignment(.center)
                        }
                }
            }
        }
    }
}
