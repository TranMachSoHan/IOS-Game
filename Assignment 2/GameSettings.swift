import Foundation
import SwiftUI

enum Mode: String, CaseIterable {
    case easy, medium, hard
}

class GameSettings: ObservableObject {
  @Published var mode: Mode = .easy
  
  // game theme
  @Published var selectedTheme: ThemeName {
      didSet {
          UserDefaults.standard.set(selectedTheme.rawValue, forKey: "theme")
      }
  }

  @Published var selectedSave: GameSave?
    
    var theme: GameTheme {
        switch selectedTheme {
        case .bismuth:
            return GameThemes.bismuth
        case .blue:
            return GameThemes.blue
        case .green:
            return GameThemes.green
        case .iridescent:
            return GameThemes.iridescent
        case .metallic:
            return GameThemes.metallic
        case.opal:
            return GameThemes.opal
        case .red:
            return GameThemes.red
        case .regal:
            return GameThemes.regal
        case .vaporwave:
            return GameThemes.vaporwave
        }
    }
    
    init() {
        selectedTheme = ThemeName(rawValue: UserDefaults.standard.string(forKey: "theme") ?? ThemeName.green.rawValue)!
    }
}
