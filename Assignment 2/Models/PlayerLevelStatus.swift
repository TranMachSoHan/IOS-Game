/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 14/08/2023
  Last modified: 02/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/


import Foundation

// Defined with @objc to allow it to be used with @NSManaged.
enum GameLevel
{
    case easy
    case difficult
}

enum Progress {
    case inProgress
    case finished
    case resume
}

struct PlayerGameTest {
    var manaPoint: Int = 0
    var bloodPoint: Int = 100
}

struct CellTest : Hashable{
    var Character : CharacterTest
}

class PlayerLevelStatusTest: ObservableObject {
    @Published var round: Int = 0
    @Published var level: GameLevel = .easy
    @Published var progress: Progress = .inProgress
    @Published var mainBoard: [[CellTest]] = [[CellTest]](repeating: [CellTest](repeating: CellTest(Character: CharacterTest()), count: 4), count: 4)
    @Published var mainPlayer: Player = Player()
    @Published var botPlayer: Player = Player()
}
