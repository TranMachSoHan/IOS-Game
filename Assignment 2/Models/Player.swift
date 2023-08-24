/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 07/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui
*/

import Foundation

class CurrentPlayer: ObservableObject  {
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var imageName: String = ""
    @Published var gameLevel: Int = 0
    @Published var badges: [String] = []
    @Published var levelStatusTest: [PlayerLevelStatusTest] = []
    
    func CurrentPlayer(name: String, chip: Int) {
        self.name = name
        self.gameLevel = 0
    }
    
    func setPlayer(player: Player){
        self.id = player.id?.uuidString ?? ""
        self.name = player.name ?? ""
        self.imageName = player.imageName ?? ""
        let badge = player.badges ?? []
        self.badges = badge.compactMap { $0 as String }
    }
}
