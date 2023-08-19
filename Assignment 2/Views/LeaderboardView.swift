/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 18/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import SwiftUI

struct LeaderboardView: View {
    @State var leaderboard : [[String:String]] = [
        ["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],
        ["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],["name" : "PlayerA", "score": "10"],
        ["name" : "PlayerB", "score": "10"],
    ]
    
    var body: some View {
        ZStack (alignment: .top){
            Color.blue
                .ignoresSafeArea(.all)
            VStack {
                Text("Leaderboard")
                    .foregroundColor(Color.red)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                //show the name and score of leaderboard array
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0))
                    .frame(width: 300, height: 50.0)
                    .overlay(
                        HStack {
                            Text("Player")
                            Spacer()
                            Text("Badge")
                            Spacer()
                            Text("Score")
                        }.padding(10)
                    )
                
                ScrollView{
                    ForEach(leaderboard, id: \.self) { player in
                        if ((player["name"]) != nil) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.pink)
                            .frame(width: 300, height: 50.0)
                            .overlay(
                                HStack {
                                    Text(player["name"]!)
                                    Spacer()
                                    Text(player["score"]!)
                                }.padding(10)
                            )
                        }
                    }
                }
                
            }
        }
    }
}


struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
