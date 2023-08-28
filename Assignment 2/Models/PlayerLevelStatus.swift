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
import SwiftUI

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

struct PlayerGame: Hashable {
    var id: UUID = UUID()
    var manaPoint: Int = 5
    var bloodPoint: Int = 100
    var imageName: String = "robot"
    var isAI: Bool = false
    var color: Color
    
    var image: Image {
        return Image(imageName)
    }
    
    var characterDeck: [Character] = []
    var displayCharacterDeck: [Character] = []

    mutating func removeDeck(removedCharacter: Character) {
        let index = self.displayCharacterDeck.firstIndex(where: {$0.characterName == removedCharacter.characterName})
        self.characterDeck.append(self.displayCharacterDeck.remove(at: index ?? 0))
        self.displayCharacterDeck.insert(characterDeck.remove(at: 0), at: index ?? 0)
    }
    
    mutating func updatePlayerStatus(manaPoint: Int = 0, bloodPoint: Int = 0){
        self.manaPoint = self.manaPoint - manaPoint
        self.bloodPoint = self.bloodPoint - bloodPoint
    }
    init(color: Color){
        let randomDeck = [
            Character(characterName: "kimetsu", manaPoint: 3, bloodPoint: 2, attackPoint: 1),
            Character(characterName: "ryu", manaPoint: 1, bloodPoint: 2, attackPoint: 1),
            Character(characterName: "vampire", manaPoint: 2, bloodPoint: 2, attackPoint: 1),
            Character(characterName: "knight", manaPoint: 3, bloodPoint: 2, attackPoint: 1),
            Character(characterName: "samurai", manaPoint: 1, bloodPoint: 2, attackPoint: 1),
            Character(characterName: "robin-hood", manaPoint: 2, bloodPoint: 2, attackPoint: 1),
        ]
        
        self.characterDeck = randomDeck.shuffled()
        for _ in 1...3{
            self.displayCharacterDeck.append(characterDeck.remove(at: 0))
        }
        self.color = color
    }
}

struct Cell : Hashable{
    var character : Character = Character()
    var isAttackedCell : Bool = false
    var isBlockedBy: PlayerGame?
}

struct MainBoard: Hashable{
    var cells: [[Cell]] = [[Cell]](repeating: [Cell](repeating: Cell(), count: 4), count: 4)
}

struct PlayerLevelStatus: Hashable {
    var level: GameLevel = .easy
    var mainBoard: MainBoard = MainBoard()
    var mainPlayer: PlayerGame = PlayerGame(color: .green)
    var botPlayer: PlayerGame = PlayerGame(color: .red)
    var playerTurn: PlayerGame
    
    init(){
        self.playerTurn = botPlayer
    }
    
    mutating func removePlayerDeck(removedCharacter: Character){
        if self.playerTurn == self.botPlayer {
            self.botPlayer.removeDeck(removedCharacter: removedCharacter)
        }
        else {
            self.mainPlayer.removeDeck(removedCharacter: removedCharacter)
        }
    }
    
    func twoDArrayToColumnAndRowTuplesWithFilter(_ array: [[Cell]]) -> [(Int, Int)] {
        return array.enumerated().flatMap { (index, row) in
            row.enumerated().filter { $0.element.character.characterName == "" }.map { ($0.offset, index) }
        }
    }
    
    mutating func addCharacterInCell(row: Int, col: Int, selectedCharacter: Character){
        self.mainBoard.cells[col][row].character = selectedCharacter
    }
    
    mutating func updatePlayerTurn(player: PlayerGame){
        self.playerTurn = player
    }
    
    mutating func botProcess(){
        // process AI deck with point
        // filter the current card with less mana than the bot
        let availableDecks = self.botPlayer.displayCharacterDeck.filter { character in
            character.manaPoint < self.botPlayer.manaPoint
        }
        
        // Check available deck and random whether should spend mana to buy
        if availableDecks.isEmpty{
            return
        }
        
        var selectedCharacter = availableDecks[0]
        let emptyCells = twoDArrayToColumnAndRowTuplesWithFilter(self.mainBoard.cells)
        if emptyCells.isEmpty {
            return
        }
        
        var selectedCellTuple = emptyCells[Int.random(in: 0..<emptyCells.count)]
        self.addCharacterInCell(row: selectedCellTuple.1, col: selectedCellTuple.0, selectedCharacter: selectedCharacter)
        self.removePlayerDeck(removedCharacter: selectedCharacter)
    }
}
