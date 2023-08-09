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

import Foundation

import SwiftUI

class GameSettings: ObservableObject {
    // Define the size of board
    @Published var numsOfRow: Int
    @Published var numsOfColumn: Int
    @Published var numsOfMonster: Int
    
    //Define the size of each square
    var squareSize: CGFloat {
        UIScreen.main.bounds.width / CGFloat(numsOfColumn)
    }
    
    init() {
        self.numsOfRow = 4
        self.numsOfColumn = 4
        self.numsOfMonster = 2
    }
}
