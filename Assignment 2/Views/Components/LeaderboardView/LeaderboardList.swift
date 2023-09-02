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
import CoreData

struct LeaderboardList: View {
    //Fetch players
    @FetchRequest var player: FetchedResults<Player>
    @EnvironmentObject var currentPlayer: CurrentPlayer
    var difficultyMode: DifficultyMode
    
    init(difficultyMode: DifficultyMode) {
        self.difficultyMode = difficultyMode
        var sortDescriptor: NSSortDescriptor
        if difficultyMode == .easy {
            sortDescriptor = NSSortDescriptor(keyPath: \Player.easyLevel, ascending: false)
        }
        else if difficultyMode == .medium {
            sortDescriptor = NSSortDescriptor(keyPath: \Player.mediumLevel, ascending: false)
        }
        else {
            sortDescriptor = NSSortDescriptor(keyPath: \Player.hardLevel, ascending: false)
        }
        
        let request: NSFetchRequest<Player> = Player.fetchRequest()
        request.sortDescriptors = [sortDescriptor]
        _player = FetchRequest<Player>(fetchRequest: request)
    }
    
    var body: some View {
        VStack {
            VStack {
                //display the fetch result to list
                ForEach(player) {player in
                    LeaderboardRow(player: player, isCurrentPlayer: currentPlayer.id == player.id?.uuidString, difficultyMode: difficultyMode)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

