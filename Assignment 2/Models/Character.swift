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
    var leftUpAttack : Bool = false
    var leftDownAttack : Bool = false
    var rightUpAttack : Bool = false
    var rightDownAttack : Bool = false
    
    init(characterName: String = "") {
        self.characterName = characterName
    }
    
    var imageCard: Image {
        Image(characterName)
    }
    
    var imageChibi: Image {
        Image(characterName + "_chibi")
    }
    
    mutating func resetCharacterAttribute() {
        self.characterName = ""
    }
    
    mutating func setPoint(
        manaPoint: Int,
        upAttackQty: Binding<Int>,
        downAttackQty: Binding<Int>,
        leftAttackQty: Binding<Int>,
        rightAttackQty: Binding<Int>,
        leftDownAttackQty: Binding<Int>,
        rightDownAttackQty: Binding<Int>,
        leftUpAttackQty: Binding<Int>,
        rightUpAttackQty: Binding<Int>){
        var totalPoint = 0
        switch manaPoint{
            case 1:
                totalPoint = 6
            case 2:
                totalPoint = 8
            case 3:
                totalPoint = 11
            default:
                totalPoint = 8
        }
        
        // Make sure the total point skill is equivalent to the totalPoint
        // Ensure the balance of a character
        var bloodPoint = Int.random(in: 1...totalPoint)
        totalPoint -= bloodPoint
        
        // Direction
        if upAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.upAttack = true
                upAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        
        if downAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.downAttack = true
                downAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        
        if leftAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.leftAttack = true
                leftAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        
        if rightAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.rightAttack = true
                rightAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        if leftUpAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.leftUpAttack = true
                leftUpAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        
        if leftDownAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.leftDownAttack = true
                leftDownAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        
        if rightUpAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.rightUpAttack = true
                rightUpAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        
        if rightDownAttackQty.wrappedValue != 0 && totalPoint != 0{
            if Bool.random(){
                self.rightDownAttack = true
                rightDownAttackQty.wrappedValue -= 1
                totalPoint -= 1
            }
        }
        
        // remaining
        var attackPoint = totalPoint
        
        // Update Point for the character
        self.manaPoint = manaPoint
        self.bloodPoint = bloodPoint
        self.attackPoint = attackPoint
    }
}
