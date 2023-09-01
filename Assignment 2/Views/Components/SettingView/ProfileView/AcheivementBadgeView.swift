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

struct AcheivementBadgeView: View {
    var playerBadges: [String]
    @State var achievementBadges: [Badge] = badges
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var gameSettings: GameSettings
    
    let columns = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
    ]
    
    var body: some View {
        ScrollView{
            VStack (alignment: .leading){
                Text("Acheivement")
                    .modifier(HeadingModifier())
                ZStack (alignment: .topLeading){
                    Rectangle()
                        .fill(gameSettings.menuTheme.fourthLevelColor.opacity(0.2))
                        .cornerRadius(20)
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(achievementBadges, id: \.self) {badge in
                            BadgeItem(badge: badge)
                        }
                    }
                }
                
            }.padding(.horizontal, 20)
            
        }.onAppear{
            self.achievementBadges = badges.filter{ badge in
                return playerBadges.contains(badge.name)
            }
        }
        .frame(height: .infinity)
    }
}


struct AcheivementBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        AcheivementBadgeView(playerBadges: ["New Member", "Level 1", "Level 2", "Level 3"])
            .environmentObject(GameSettings())
    }
}
