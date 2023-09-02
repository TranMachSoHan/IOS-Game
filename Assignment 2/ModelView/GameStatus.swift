/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 11/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import Foundation


class GameStatus: ObservableObject {
    @Published var level: Int = 0
    @Published var mode: DifficultyMode = .easy
    @Published var mainBoard: MainBoard = MainBoard()
    @Published var mainPlayer: PlayerGame
    @Published var playerTurn: PlayerGame
    @Published var botPlayer: PlayerGame
    @Published var turn = 0
    @Published var botOriginPosition: [(Int, Int)] = []
    @Published var victory: Bool = false
    @Published var gameOver: Bool = false
    
    init(level: Int = 1, mode: DifficultyMode = .easy){
        self.level = level
        self.mode = mode
        self.mainPlayer = PlayerGame(color: .blue)
        self.botPlayer = PlayerGame(color: .purple, isAI: true)
        self.playerTurn = PlayerGame(color: .clear)
        self.playerTurn = botPlayer
        self.setUpMode(level: level, mode: mode)
    }
    
    func setUpMode(level: Int = 3, mode: DifficultyMode = .easy){
        self.playerTurn = Bool.random() ? mainPlayer : botPlayer
        
        if mode == .easy {
            if level <= 5 {
                let progress = findProgressByLevel(level: level)
                self.playerTurn = progress.turn == "player" ? mainPlayer : botPlayer
                self.botPlayer.bloodPoint = progress.player.bloodPoint
                self.mainPlayer.bloodPoint = progress.bot.bloodPoint
                self.botOriginPosition = progress.getOriginPositionArr
                self.mainPlayer.prepareDeckCard(manaCharacter: progress.player.manaArr, upAttackQty: progress.player.upAttackQty, downAttackQty: progress.player.downAttackQty)
                self.botPlayer.prepareDeckCard(manaCharacter: progress.player.manaArr, upAttackQty: progress.player.upAttackQty, downAttackQty: progress.player.downAttackQty)
            }
            else {
                self.botPlayer.bloodPoint = 30
                self.mainPlayer.bloodPoint = 30
                self.mainPlayer.prepareDeckCard()
                self.botPlayer.prepareDeckCard()
            }
        }
        else if mode == .medium {
            self.botPlayer.bloodPoint = 50
            self.mainPlayer.bloodPoint = 50
            self.mainPlayer.prepareDeckCard(leftUpAttackQty: 6, rightUpAttackQty: 6, leftDownAttackQty: 6, rightDownAttackQty: 6)
            self.botPlayer.prepareDeckCard(leftUpAttackQty: 6, rightUpAttackQty: 6, leftDownAttackQty: 6, rightDownAttackQty: 6)
        }
        
        if self.playerTurn.id == botPlayer.id{
            self.botLoading()
        }
    }
    
    func botLoading () {
        // Bot turn
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            self.botProcess()
        }
    }
    
    func botProcess(){
        var waitingTime = 0
        
        // process AI deck with point
        // filter the current card with less mana than the bot
        let availableDecks = botPlayer.displayCharacterDeck.filter { character in
            character.manaPoint < botPlayer.manaPoint
        }
        // Check available deck and random whether should spend mana to buy
        if !availableDecks.isEmpty{
            let selectedCharacter = availableDecks[0]
            let emptyCells = twoDArrayToColumnAndRowTuplesWithFilter(mainBoard.cells)
            
            
            // No empty cells
            if !emptyCells.isEmpty {
                let selectedCellTuple = emptyCells[Int.random(in: 0..<emptyCells.count)]
                self.updateActionFlow(row: selectedCellTuple.1, col: selectedCellTuple.0, selectedCharacter: selectedCharacter)
                waitingTime = 2
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(waitingTime)){ [self] in
            self.updateNextPlayer()
        }
    }
    
    func updateNextPlayer(){
        turn = turn + 1
        var waitingTime = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2)){ [self] in
            // Update existing character and minus point
            if turn >= 2 {
                turn = 0
                let flatMainBoard = mainBoard.cells.flatMap { $0 }
                
                let mainPlayerBloodReduced = flatMainBoard
                    .filter { $0.isBlockedBy?.id == botPlayer.id }
                    .map({$0.character.attackPoint}).reduce(0, +)
                self.mainPlayer.updatePlayerStatus(manaPoint: 1, bloodPoint: -mainPlayerBloodReduced)
                
                let mainBotBloodReduced = flatMainBoard
                    .filter { $0.isBlockedBy?.id == mainPlayer.id }
                    .map({$0.character.attackPoint}).reduce(0, +)
                self.botPlayer.updatePlayerStatus(manaPoint: 1, bloodPoint: -mainBotBloodReduced)
                
                // increase waiting time to do animation update Blood point
                waitingTime = 2
                
                // Update victory and game over
                // Game view receive change will show announcement view
                self.checkVictoryStatus()
                if self.victory || self.gameOver {
                    return
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(waitingTime)) { [self] in
                self.playerTurn = self.playerTurn.id == self.botPlayer.id ? mainPlayer : botPlayer
            }
        }
        
        
    }
    func updateActionFlow(row: Int, col: Int, selectedCharacter: Character){
        self.removePlayerDeck(removedCharacter: selectedCharacter)
        self.addCharacterInCell(row: row, col: col, selectedCharacter: selectedCharacter)
    }
    
    func checkVictoryStatus(){
        
        var isVictory = false
        if self.botPlayer.bloodPoint < 0 {
            isVictory = true
        }
        
        if self.mainPlayer.bloodPoint < 0 && !isVictory{
            self.gameOver = true
        }
        
        self.victory = isVictory
    }
    
    func removePlayerDeck(removedCharacter: Character){
        if playerTurn == botPlayer {
            self.botPlayer.removeDeck(removedCharacter: removedCharacter)
        }
        else {
            self.mainPlayer.removeDeck(removedCharacter: removedCharacter)
        }
    }
    
    // mapping 2D array to tuple row, col
    func twoDArrayToColumnAndRowTuplesWithFilter(_ array: [[Cell]]) -> [(Int, Int)] {
        return array.enumerated().flatMap { (index, row) in
            row.enumerated().filter { $0.element.character.characterName == "" }.map { ($0.offset, index) }
        }
    }
    
    // from the tuple index of character, find the list of cell matching the direction of chracter
    // then convert the status of the cell: isAttackedCell to be true
    func boldAttackedCells(row: Int, col: Int, selectedCharacter: Character) -> [(Int, Int)]{
        
        // Declare to store enemy cells in the attack direction
        var enemyCellsEntry: [(Int, Int)] = []
        // closure function
        let checkCellsAndAppend: (Int, Int) -> Void = { col, row in
            self.mainBoard.cells[col][row].isAttackedCell = true
            if self.mainBoard.cells[col][row].isBlockedBy?.getIDString != self.playerTurn.getIDString{
                enemyCellsEntry.append((col, row))
            }
        }
        
        // Character has the direction including: up, down, right and left
        if selectedCharacter.upAttack{
            for attackedRow in (0..<row){
                checkCellsAndAppend(col, attackedRow)
            }
        }
        
        if selectedCharacter.downAttack{
            for attackedRow in (row+1..<self.mainBoard.cells.count){
                checkCellsAndAppend(col, attackedRow)
            }
        }
        
        if selectedCharacter.rightAttack{
            for attackedCol in (col+1..<self.mainBoard.cells[0].count){
                checkCellsAndAppend(attackedCol, row)
            }
        }

        if selectedCharacter.leftAttack{
            for attackedCol in (0..<col){
                checkCellsAndAppend(attackedCol, row)
            }
        }
        
        if selectedCharacter.leftUpAttack{
            var attackedCol = col - 1
            var attackedRow = row - 1
            while attackedCol >= 0 && attackedRow >= 0{
                checkCellsAndAppend(attackedCol, attackedRow)
                attackedCol -= 1
                attackedRow -= 1
            }
        }
        
        if selectedCharacter.rightUpAttack{
            var attackedCol = col + 1
            var attackedRow = row - 1
            while attackedCol < self.mainBoard.cells[0].count && attackedRow >= 0{
                checkCellsAndAppend(attackedCol, attackedRow)
                attackedCol += 1
                attackedRow -= 1
            }
        }
        
        if selectedCharacter.leftDownAttack{
            var attackedCol = col - 1
            var attackedRow = row + 1
            while attackedCol >= 0 && attackedRow < self.mainBoard.cells.count{
                checkCellsAndAppend(attackedCol, attackedRow)
                attackedCol -= 1
                attackedRow += 1
            }
        }
        
        if selectedCharacter.rightDownAttack{
            var attackedCol = col + 1
            var attackedRow = row + 1
            while attackedCol < self.mainBoard.cells[0].count && attackedRow < self.mainBoard.cells.count{
                checkCellsAndAppend(attackedCol, attackedRow)
                attackedCol += 1
                attackedRow += 1
            }
        }
        
        return enemyCellsEntry
    }
    
    // add character to 2D cell in the mainboard
    // Here is the main logic after character is allocated in the cell
    func addCharacterInCell(row: Int, col: Int, selectedCharacter: Character){
        self.mainBoard.cells[col][row].character = selectedCharacter
        self.mainBoard.cells[col][row].isBlockedBy = self.playerTurn
        
        // Update ManaPoint
        if playerTurn.id == botPlayer.id {
            self.botPlayer.updatePlayerStatus(manaPoint: -selectedCharacter.manaPoint)
        }
        else {
            self.mainPlayer.updatePlayerStatus(manaPoint: -selectedCharacter.manaPoint)
        }
        
        // Start attack
        let attackCells = self.boldAttackedCells(row: row, col: col, selectedCharacter: selectedCharacter)
        
        
        for (col, row) in attackCells{
            let cell = self.mainBoard.cells[col][row]
            if cell.character.bloodPoint < selectedCharacter.attackPoint{
                self.mainBoard.cells[col][row].isDead = true
            }
        }
    }
}
