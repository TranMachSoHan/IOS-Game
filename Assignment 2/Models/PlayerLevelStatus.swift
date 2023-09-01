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

let availableCharacterName = ["kimetsu", "ryu", "vampire", "knight", "samurai", "robin-hood"]
let availableBotName = ["bot1", "bot2", "bot3", "bot4", "bot5", "bot6"]

struct PlayerGame: Hashable {
    var id: UUID = UUID()
    var manaPoint: Int = 5
    var bloodPoint: Int = 100
    var imageName: String = "robot"
    var color: Color
    var isAI: Bool
    
    var getIDString: String{
        return id.uuidString
    }
    
    var image: Image {
        return Image(imageName)
    }
    
    var characterDeck: [Character] = []
    var displayCharacterDeck: [Character] = []

    mutating func removeDeck(removedCharacter: Character) {
        let index = self.displayCharacterDeck.firstIndex(where: {$0.characterName == removedCharacter.characterName})
        self.displayCharacterDeck.remove(at: index ?? 0)
        if (self.characterDeck.count != 0){
            self.displayCharacterDeck.insert(characterDeck.remove(at: 0), at: index ?? 0)
        }
    }
    
    mutating func prepareDeckCard(
        manaCharacter: [Int] = [],
        upAttackQty: Int = 0,
        downAttackQty: Int = 0,
        leftAttackQty: Int = 0,
        rightAttackQty: Int = 0
    ){
        var characterNameCopy = self.isAI ? availableBotName.shuffled() : availableCharacterName.shuffled()
        
        var manaCharacter = manaCharacter
        var upAttackQty = upAttackQty
        var downAttackQty = downAttackQty
        var leftAttackQty = leftAttackQty
        var rightAttackQty = rightAttackQty
        
        var deck: [Character] = []
        
        for _ in 1...availableCharacterName.count {
            let manaPoint = manaCharacter.isEmpty ? Int.random(in: 1...3) : manaCharacter.remove(at: 0)
            var character = Character(characterName: characterNameCopy.remove(at: 0))
            character.setPoint(manaPoint: manaPoint,
                               upAttackQty: Binding(get: {upAttackQty}, set: {upAttackQty = $0}),
                               downAttackQty: Binding(get: {downAttackQty}, set: {downAttackQty = $0}),
                               leftAttackQty: Binding(get: {leftAttackQty}, set: {leftAttackQty = $0}),
                               rightAttackQty: Binding(get: {rightAttackQty}, set: {rightAttackQty = $0}))
            deck.append(character)
        }
        
        self.characterDeck = deck.shuffled()
        for _ in 1...3{
            self.displayCharacterDeck.append(characterDeck.remove(at: 0))
        }
    }
    
    mutating func appendDeckAtEnd(removedCharacter: Character) {
        self.characterDeck.append(removedCharacter)
    }

    mutating func updatePlayerStatus(manaPoint: Int = 0, bloodPoint: Int = 0){
        self.manaPoint = self.manaPoint + manaPoint
        self.bloodPoint = self.bloodPoint + bloodPoint
    }
    init(color: Color, isAI: Bool = false){
        self.isAI = isAI
        self.color = color
    }
    
    
}

struct Cell : Hashable{
    var character : Character = Character()
    var isAttackedCell : Bool = false
    var isProtectedCell : Bool = false
    var isDead : Bool = false
    var isBlockedBy: PlayerGame?
    
    init(){
        self.isBlockedBy = nil
    }
}

struct MainBoard: Hashable{
    var cells: [[Cell]] = [[Cell]](repeating: [Cell](repeating: Cell(), count: 4), count: 4)
}
