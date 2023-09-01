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

struct LevelView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @EnvironmentObject var gameSettings: GameSettings
    @State var showPopUpBadge: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                VStack {
                    Text("\(gameSettings.difficultyMode.rawValue.capitalized) Mode")
                        .font(.system(size: geo.size.width/10, design: .rounded))
                    ForEach(1..<15, id: \.self) { level in
                        // Unable the access to the lower level of the user
                        let isLocked: Bool = level > currentPlayer.levelUnlock(mode: gameSettings.difficultyMode)
                        
                        Button {
                            if !isLocked{
                                gameSettings.level = level
                                viewRouter.currentPage = .gamePage
                            }
                        } label: {
                            Capsule()
                                .fill(gameSettings.menuTheme.secondLevelColor.opacity(isLocked ? 0.3 : 1))
                                .overlay(
                                    HStack{
                                        
                                        Text("Level \(level)")
                                            .font(.system(size: geo.size.width/15))
                                            .fontWeight(.bold)
                                            .foregroundColor(gameSettings.menuTheme.fourthLevelColor)
                                        Spacer()
                                        Image(systemName: isLocked ? "lock" : "lock.open")
                                    }
                                    .padding(geo.size.width/10)
                                )
                        }
                        .frame(height: geo.size.height/15)
                        .padding(.bottom, 10)
                    }
                }
            }
        }
    }
    
   
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
            .environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
            .environmentObject(GameSettings())
    }
}
