import Foundation
import SwiftUI

enum Mode: String, CaseIterable {
    case easy, medium, hard
}

enum Locale: String, CaseIterable, Hashable {
    case en: "English",
    case vn: "Vietnam",
}

class GameSettings: ObservableObject {
    // Difficulty Mode
    @Published var mode: Mode = .easy
  
    // Locale 
    @Published var locale: ThemeName {
      didSet {
          UserDefaults.standard.set(locale, forKey: "locale")
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
    
    init() {
        selectedTheme = ThemeName(rawValue: UserDefaults.standard.string(forKey: "theme") ?? ThemeName.green.rawValue)!
        darkMode = UserDefaults.standard.string(forKey: "darkMode") ?? false
        locale = UserDefaults.standard.string(forKey: "locale") ?? Locale.en
    }
}
