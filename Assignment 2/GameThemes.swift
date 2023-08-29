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
    Code: https://github.com/PScottZero/Checkmate/blob/master/Checkmate/Settings/GameThemes.swift
    Palete light: https://colorhunt.co/palette/fff7d4ffd95ac07f004c3d3d
*/

import Foundation
import SwiftUI
import SpriteKit

struct MenuTheme {
    let menuBackgroundImage : String,
    let backgroundColor: SKColor,
    let buttonColor: SKColor,
    let textColor: SKColor

    init(
        menuBackgroundImage: String,
        topLevelColor: SKColor,
        secondLevelColor: SKColor,
        thirdLevelColor: SKColor,
        fourthLevelColor: SKColor
    ){
        self.menuBackgroundImage = menuBackgroundImage
        self.topLevelColor = topLevelColor
        self.secondLevelColor = secondLevelColor
        self.thirdLevelColor = thirdLevelColor
        self.fourthLevelColor = fourthLevelColor
    }
}

struct GameTheme {
    let gameBackgroundImages: [String],
    let borderPlayerImageColor: SKColor,
    let boardColor: SKColor,
    let statusTextcolor: SKColor,
    let imageOverlayOpacity: Double,
    let manaBarColor: SKColor,
    let borderCharacterSelected: SKColor

    init(
        gameBackgroundImages: [String],
        borderPlayerImageColor: SKColor,
        boardColor: SKColor,
        statusTextcolor: SKColor,
        imageOverlayOpacity: SKColor,
        manaBarColor: SKColor,
        borderCharacterSelected: SKColor
    ){
        self.gameBackgroundImages = gameBackgroundImages
        self.borderPlayerImageColor = borderPlayerImageColor
        self.boardColor = boardColor
        self.statusTextcolor = statusTextcolor
        self.imageOverlayOpacity = imageOverlayOpacity
        self.manaBarColor = manaBarColor
        self.borderCharacterSelected = borderCharacterSelected
    }
}

struct GameThemes {
    static let lightMode = MenuTheme(
        gameBackgroundImages: [],
        borderPlayerImageColor: SKColor(red: 76 / 255, green: 61 / 255, blue: 61 / 255, alpha: 1),
        boardColor: SKColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1),
        statusTextcolor: SKColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1),
        imageOverlayOpacity: 0.2,
        manaBarColor: SKColor(red: 0 / 255, green: 100 / 255, blue: 0 / 255, alpha: 1),
        borderCharacterSelected: SKColor(red: 192 / 255, green: 127 / 255, blue: 0 / 255, alpha: 1)
    )

    static let darkMode = MenuTheme(
        gameBackgroundImages: [],
        borderPlayerImageColor: SKColor(red: 255 / 255, green: 247 / 255, blue: 212 / 255, alpha: 1),
        boardColor: SKColor(red: 169 / 255, green: 169 / 255, blue: 169 / 255, alpha: 0/7),
        statusTextcolor: SKColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1),
        imageOverlayOpacity: 0.7,
        manaBarColor: SKColor(red: 0 / 255, green: 255 / 255, blue: 0 / 255, alpha: 1),
        borderCharacterSelected: SKColor(red: 255 / 255, green: 192 / 255, blue: 76 / 255, alpha: 1)
    )
}

