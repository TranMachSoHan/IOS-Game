/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 09/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import Foundation

struct GameProgress: Encodable, Decodable{
    var level: Int = 0
    var mode: String = DifficultyMode.easy.rawValue
    var mainBoard: MainBoard = MainBoard()
    var mainPlayer: PlayerGame = PlayerGame(color: "clear")
    var playerTurn: PlayerGame = PlayerGame(color: "clear")
    var botPlayer: PlayerGame = PlayerGame(color: "clear")
    var turn = 0
    var victory: Bool = false
    var gameOver: Bool = false
    
    var showPlayerTurn : String{
        return self.playerTurn.id == mainPlayer.id ? "Your turn" : "Bot turn"
    }
    
    var difficultyMode: DifficultyMode{
        return DifficultyMode(rawValue: mode) ?? .easy
    }
    
    mutating func convertGameStatusToGameProgress(gameStatus: GameStatus){
        self.level = gameStatus.level
        self.mode = gameStatus.mode.rawValue
        self.mainBoard = gameStatus.mainBoard
        self.mainPlayer = gameStatus.mainPlayer
        self.playerTurn = gameStatus.playerTurn
        self.botPlayer = gameStatus.botPlayer
        self.turn = gameStatus.turn
        self.victory = gameStatus.victory
        self.gameOver = gameStatus.gameOver
    }
    
}
