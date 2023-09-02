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
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
        ZStack (alignment: .topLeading){
            
            TabView {
                ForEach(DifficultyMode.allCases, id: \.self) { mode in
                    LeaderboardList(difficultyMode: mode)
                        .tabItem {
                            Text("\(mode.rawValue.capitalized)")
                                .modifier(HeadingModifier())
                        }
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
        }.edgesIgnoringSafeArea(.all)
    }
    
    
}


struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
            .environmentObject(CurrentPlayer())
    }
}
