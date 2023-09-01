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

struct LeaderboardList: View {
    @State var difficultyMode : DifficultyMode
    //Fetch players
    @FetchRequest(sortDescriptors: []) var player: FetchedResults<Player>
    @EnvironmentObject var currentPlayer: CurrentPlayer
    
    var body: some View {
        VStack {
            VStack {
                //display the fetch result to list
                ForEach(player) {player in
                    LeaderboardRow(player: player, isCurrentPlayer: currentPlayer.id == player.id?.uuidString)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

