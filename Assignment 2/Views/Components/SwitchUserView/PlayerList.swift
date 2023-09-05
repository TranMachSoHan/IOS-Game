/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 19/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://www.pinterest.com/imabamfyo/game-ui-splash-welcome-screens/
    https://stackoverflow.com/questions/56443535/swiftui-text-alignment
*/

import SwiftUI

struct PlayerList: View {
    //Fetch players
    var players: FetchedResults<Player>
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Binding var name: String
    @Binding var password: String
    @Binding var showPopUpAuth: Bool
    @Binding var popUpTypeString: String
    @Binding var clickedPlayerId: String
    
    let columns = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
    ]
    
    var body: some View {
        VStack {
            Text("Choose Player")
                .font(.title)
            
            if (players.isEmpty){
                Image("no-data")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 100)
                Text("No Player in database")
                    .font(.system(size: 30))
                
            }
            else{
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(players) {player in
                        PlayerRow(player: player)
                            .border(.red, width: currentPlayer.id == player.id?.uuidString ? 7 : 0)
                            .onTapGesture {
                                name = player.name!
                                password = ""
                                showPopUpAuth = true
                                popUpTypeString = "Sign In"
                                clickedPlayerId = player.id?.uuidString ?? ""
                            }
                    }
                }
            }
        }
        
    }
}

