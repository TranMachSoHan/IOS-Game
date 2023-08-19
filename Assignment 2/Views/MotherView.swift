/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 07/08/2023
  Last modified: 02/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    var settings = GameSettings()
    
    var body: some View {
        //Display the corresponding view based on the varible
        switch viewRouter.currentPage {
            case .menuPage:
                MenuView()
            case .gamePage:
                GameView()
            case .switchUser:
                SwitchUserView()
            case .leaderboardPage:
                LeaderboardView()
            case .howToPlayPage:
                MenuView()
            case .levelSettingPage:
                MenuView()
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ViewRouter())
    }
}
