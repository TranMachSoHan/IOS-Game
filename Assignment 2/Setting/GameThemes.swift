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
    let menuBackgroundImage : String
    let topLevelColor: Color
    let secondLevelColor: Color
    let thirdLevelColor: Color
    let fourthLevelColor: Color
    let boardColor: Color
    let manaBarColor: Color
    let borderCharacterSelected: Color

    init(
        menuBackgroundImage: String,
        topLevelColor: Color,
        secondLevelColor: Color,
        thirdLevelColor: Color,
        fourthLevelColor: Color,
        boardColor: Color,
        manaBarColor: Color,
        borderCharacterSelected: Color
    ){
        self.menuBackgroundImage = menuBackgroundImage
        self.topLevelColor = topLevelColor
        self.secondLevelColor = secondLevelColor
        self.thirdLevelColor = thirdLevelColor
        self.fourthLevelColor = fourthLevelColor
        self.boardColor = boardColor
        self.manaBarColor = manaBarColor
        self.borderCharacterSelected = borderCharacterSelected
    }
}

struct MenuThemes {
    static let lightMode = MenuTheme(
        menuBackgroundImage: "menu-background-light",
        topLevelColor: Color(red: 255 / 255, green: 247 / 255, blue: 212 / 255),
        secondLevelColor: Color(red: 255 / 255, green: 217 / 255, blue: 90 / 255),
        thirdLevelColor: Color(red: 192 / 255, green: 127 / 255, blue: 0 / 255),
        fourthLevelColor: Color(red: 76 / 255, green: 61 / 255, blue: 61 / 255),
        boardColor: Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255),
        manaBarColor: Color(red: 0 / 255, green: 100 / 255, blue: 0 / 255),
        borderCharacterSelected: Color(red: 192 / 255, green: 127 / 255, blue: 0 / 255)
    )

    static let darkMode = MenuTheme(
        menuBackgroundImage: "menu-background-dark",
        topLevelColor: Color(red: 76 / 255, green: 61 / 255, blue: 61 / 255),
        secondLevelColor: Color(red: 192 / 255, green: 127 / 255, blue: 0 / 255),
        thirdLevelColor: Color(red: 255 / 255, green: 217 / 255, blue: 90 / 255),
        fourthLevelColor: Color(red: 255 / 255, green: 247 / 255, blue: 212 / 255),
        boardColor: Color(red: 169 / 255, green: 169 / 255, blue: 169 / 255),
        manaBarColor: Color(red: 0 / 255, green: 100 / 255, blue: 0 / 255),
        borderCharacterSelected: Color(red: 192 / 255, green: 127 / 255, blue: 0 / 255)
    )
}

struct GameTheme {
    let gameBackgroundColor: Color
    let borderPlayerImageColor: Color
    let boardColor: Color
    let statusTextcolor: Color
    let imageOverlayOpacity: Double
    let manaBarColor: Color
    let borderCharacterSelected: Color

    init(
        gameBackgroundColor: Color,
        borderPlayerImageColor: Color,
        boardColor: Color,
        statusTextcolor: Color,
        imageOverlayOpacity: Double,
        manaBarColor: Color,
        borderCharacterSelected: Color
    ){
        self.gameBackgroundColor = gameBackgroundColor
        self.borderPlayerImageColor = borderPlayerImageColor
        self.boardColor = boardColor
        self.statusTextcolor = statusTextcolor
        self.imageOverlayOpacity = imageOverlayOpacity
        self.manaBarColor = manaBarColor
        self.borderCharacterSelected = borderCharacterSelected
    }
}

struct GameThemes {
    static let lightMode = GameTheme(
        gameBackgroundColor: Color.yellow,
        borderPlayerImageColor: Color(red: 76 / 255, green: 61 / 255, blue: 61 / 255),
        boardColor: Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255),
        statusTextcolor: Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255),
        imageOverlayOpacity: 0.2,
        manaBarColor: Color(red: 0 / 255, green: 100 / 255, blue: 0 / 255),
        borderCharacterSelected: Color(red: 192 / 255, green: 127 / 255, blue: 0 / 255)
    )

    static let darkMode = GameTheme(
        gameBackgroundColor: Color.brown,
        borderPlayerImageColor: Color(red: 255 / 255, green: 247 / 255, blue: 212 / 255),
        boardColor: Color(red: 169 / 255, green: 169 / 255, blue: 169 / 255),
        statusTextcolor: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),
        imageOverlayOpacity: 0.7,
        manaBarColor: Color(red: 0 / 255, green: 255 / 255, blue: 0 / 255),
        borderCharacterSelected: Color(red: 255 / 255, green: 192 / 255, blue: 76 / 255)
    )
}
