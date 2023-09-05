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
    https://www.hackingwithswift.com/books/ios-swiftui/how-to-combine-core-data-and-swiftui
    https://github.com/PScottZero/Checkmate/blob/master/Checkmate/Settings/GameSettings.swift
*/

import SwiftUI

class CurrentPlayer: ObservableObject  {
    @Published var id: String {
      didSet {
            UserDefaults.standard.set(id, forKey: "current_player")
        }
    }
    @Published var name: String = ""
    @Published var imageName: String = ""
    @Published var easyLevel: Int = 0
    @Published var mediumLevel: Int = 0
    @Published var hardLevel: Int = 0 
    @Published var badges: [String] = []

    init() {
        id = UserDefaults.standard.string(forKey: "current_player") ?? ""
    }
  
    func setPlayer(player: Player){
        self.id = player.id?.uuidString ?? ""
        self.name = player.name ?? ""
        self.imageName = player.imageName ?? ""
        self.easyLevel = Int(player.easyLevel)
        self.mediumLevel = Int(player.mediumLevel)
        let badge = player.badges ?? []
        self.badges = badge.compactMap { $0 as String }
    }

    var image : Image {
        return Image(imageName)
    }
    
    func levelUnlock(mode: DifficultyMode) -> Int{
        switch mode{
            case .easy:
                return easyLevel
            case .medium:
                return mediumLevel
        }
    }
    
    
    func saveLevelUnlock(level: Int, mode: DifficultyMode){
        switch mode{
            case .easy:
                self.easyLevel = level
            case .medium:
            self.mediumLevel = level
        }
    }
}
