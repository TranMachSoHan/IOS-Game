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
    @Environment(\.managedObjectContext) var managedObjContext
    
    //Fetch players
    @FetchRequest(sortDescriptors: []) var player: FetchedResults<Player>
    
    var body: some View {
        ZStack (alignment: .top){
            Color.blue
                .opacity(0.2)
                .ignoresSafeArea(.all)
            VStack {
                LeaderboardList()
            }
        }
    }
}


struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
