//
//  Character.swift
//  Assignment 2
//
//  Created by macOS on 10/08/2023.
//

import SwiftUI

struct Character: Hashable {
    var characterName = ""
    var manaPoint = 0
    var bloodPoint = 0
    var attackPoint = 0
    var upAttack : Bool = false
    var downAttack : Bool = false
    var leftAttack : Bool = false
    var rightAttack : Bool = false
    
    var imageCard: Image {
        Image(characterName)
    }
    
    var imageChibi: Image {
        Image(characterName + "_chibi")
    }
    
    mutating func resetCharacterAttribute() {
        self.characterName = ""
    }
}
