//
//  LevelProgress.swift
//  Assignment 2
//
//  Created by macOS on 31/08/2023.
//

import Foundation
import SwiftUI

struct EasyProgress: Codable{
    var level: Int
    var instruction: String
    var turn: String
    var botOriginPosition: [OriginPosition]
    var player: PlayerProgressStatus
    var bot: PlayerProgressStatus
    var getOriginPositionArr: [(Int, Int)] {
        return botOriginPosition.map { position in
            (position.col, position.row)
        }
    }
}

struct OriginPosition: Codable {
    var col: Int
    var row: Int
}

struct PlayerProgressStatus: Codable {
    var manaPoint: Int = 0
    var bloodPoint: Int = 0
    var manaArr: [Int] = []
    var upAttackQty: Int = 0
    var downAttackQty: Int = 0
    var leftAttackQty: Int = 0
    var rightAttackQty: Int = 0
}

func decodeEasyProgressJsonFromJsonFile(jsonFileName: String) -> [EasyProgress] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([EasyProgress].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [EasyProgress]
}


var easyProgresses: [EasyProgress] = decodeEasyProgressJsonFromJsonFile(jsonFileName: "easy-progress.json")

func findProgressByLevel(level: Int) -> EasyProgress{
    return easyProgresses.first(where: {$0.level == level}) ?? easyProgresses[0]
}
