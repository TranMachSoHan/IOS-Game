import Foundation
import SwiftUI

enum DifficultyMode: String, CaseIterable {
    case easy, medium, hard
}

enum Locale: String, CaseIterable, Hashable {
    case en: "English",
    case vn: "Vietnam",
}

class GameSettings: ObservableObject {
    // Difficulty Mode
    @Published var difficultyMode: DifficultyMode {
      didSet {
          UserDefaults.standard.set(difficultyMode.rawValue, forKey: "difficultyMode")
      }
    }
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
    
    var menuTheme: MenuTheme {
        return darkMode ? MenuThemes.darkMode : MenuThemes.lightMode
    }

    var gameTheme: GameTheme {
        return darkMode ? GameThemes.darkMode : GameThemes.lightMode
    }

    var modeDescription: String{
        switch difficultyMode {
            case .easy:
                return "Easy description"
            case .medium:
                return "Medium description"
            case .hard:
                return "Hard description"
        }
    }
    init() {
        darkMode = UserDefaults.standard.bool(forKey: "darkMode") ?? false
        locale = Locale(rawValue: UserDefaults.standard.string(forKey: "locale") ?? Locale.en.rawValue)!
        difficultyMode = DifficultyMode(rawValue: UserDefaults.standard.string(forKey: "difficultyMode") ?? DifficultyMode.easy.rawValue)!
    }
}
