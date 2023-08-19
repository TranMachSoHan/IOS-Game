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

struct BadgeTest {
    var name: String = ""
    var image: String = ""
}

class CurrentPlayer: ObservableObject, Identifiable  {
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var imageName: String = ""
    @Published var gameLevel: Int = 0
    @Published var levelStatusTest: [PlayerLevelStatusTest] = []
    @Published var badges: [BadgeTest] = []
    
    func CurrentPlayer(name: String, chip: Int) {
        self.name = name
        self.gameLevel = 0
        self.id = UUID().uuidString
    }
}
