/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 10/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import Foundation
import SwiftUI

enum DifficultyMode: String, CaseIterable {
    case easy, medium
}

enum Locale: String, CaseIterable, Hashable {
    case en
    case vn
}

class GameSettings: ObservableObject {
    // Difficulty Mode
    @Published var difficultyMode: DifficultyMode {
      didSet {
          UserDefaults.standard.set(difficultyMode.rawValue, forKey: "difficultyMode")
      }
    }
    
    @Published var level: Int = 0
    
    // Locale
    @Published var locale: Locale {
      didSet {
          UserDefaults.standard.set(locale.rawValue, forKey: "locale")
      }
    }

    // Dark Light mode
    @Published var darkMode: Bool {
      didSet {
          UserDefaults.standard.set(darkMode, forKey: "darkMode")
      }
    }
    
    @Published var badgeNameUnlock: String = ""
    
    var menuTheme: MenuTheme {
        return darkMode ? MenuThemes.darkMode : MenuThemes.lightMode
    }

    var gameTheme: GameTheme {
        return darkMode ? GameThemes.darkMode : GameThemes.lightMode
    }

    var modeDescription: String{
        switch difficultyMode {
            case .easy:
                return "Monster and Player will only have up, left, right, down attack directions. After level 5, blood of monster and player are both 15"
            case .medium:
                return "Monster and Player will have 4 extra attack directions: up left, up right, down left, down right. And the monster blood will be increased to 30"
        }
    }
    
    @Published var gameProgress: GameProgress?
    
    init() {
        darkMode = UserDefaults.standard.bool(forKey: "darkMode")
        locale = Locale(rawValue: UserDefaults.standard.string(forKey: "locale") ?? Locale.en.rawValue)!
        difficultyMode = DifficultyMode(rawValue: UserDefaults.standard.string(forKey: "difficultyMode") ?? DifficultyMode.easy.rawValue)!
    }
}
