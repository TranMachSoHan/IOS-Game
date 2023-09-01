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

@main
struct Assignment_2App: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var dataController = DataController()
    @StateObject var currentPlayer: CurrentPlayer = CurrentPlayer()
    @StateObject var gameSettings: GameSettings = GameSettings()
  
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(viewRouter)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(currentPlayer)
                .environmentObject(gameSettings)
//                .environment(\.locale, .init(identifier: $gameSettings.identifier))
        }
    }
}
