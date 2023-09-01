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
    https://blog.liftshare.com/tech/liftshare-leaderboard-levels-and-badges
*/

import SwiftUI

struct LeaderboardRow: View {
    var player: Player
    var number: Int = 0
    var isCurrentPlayer: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(
                self.isCurrentPlayer ? .blue : .gray.opacity(0.2)
            )
            .frame(height: 50.0)
            .overlay(
                HStack {
                    HStack {
                        Text("\(number)")
                            .foregroundColor(self.isCurrentPlayer ? .white : .black)
                        Image(player.imageName!)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color(.white),lineWidth: 2))
                            .padding(.vertical, 5)
                        Text(player.name!)
                            .bold()
                            .foregroundColor(self.isCurrentPlayer ?  .white : .black)
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
            )
    }
}
