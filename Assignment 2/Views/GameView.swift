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
    https://www.pinterest.com/imabamfyo/game-ui-splash-welcome-screens/
    https://stackoverflow.com/questions/56443535/swiftui-text-alignment
    https://www.pinterest.com/pin/451134087689536109/
    https://www.pinterest.com/pin/701154235755448104/
    https://www.besthdwallpaper.com/cuoi-lon/knight-zed-splash-art-lien-minh-huyen-thoai-lol-dt_vi-64746.html
    https://www.freepik.com/premium-photo/scary-black-werewolf-illustration-full-body-3d-rendering_33092555.htm
    https://betterprogramming.pub/create-an-awesome-loading-state-using-swiftui-9815ff6abb80
*/


import SwiftUI

var emptyCharacter : Character = Character()
struct GameView: View {
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var dataController: DataController
    @State var draggedCharacter: Character = emptyCharacter
    @ObservedObject var gameStatus: GameStatus
    
    var body: some View {
            ZStack{
                
                
                //Background
//                Image("game-background-1")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)
//                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack {
                    PlayerStatusView(
                        image: gameStatus.botPlayer.image,
                        bloodPoint: $gameStatus.botPlayer.bloodPoint,
                        manaPoint: $gameStatus.botPlayer.manaPoint,
                        manaPositionTop: false,
                        showDeck: false,
                        draggedCharacter: $draggedCharacter,
                        player: $gameStatus.botPlayer,
                        playerTurn: $gameStatus.playerTurn,
                        displayCharacterDeck: $gameStatus.botPlayer.displayCharacterDeck,
                        showLoading: true,
                        gameStatus: gameStatus
                    )
                    .frame(height: 150)
                    
                    ForEach(0..<4, id: \.self) { row in
                        HStack {
                            ForEach(0..<4, id: \.self) { col in
                                CellCharacterStatusView(cell: $gameStatus.mainBoard.cells[col][row], draggedCharacter: $draggedCharacter)
                                    .onTapGesture {
                                        withAnimation {
                                            if draggedCharacter.characterName != "" {
                                                gameStatus.updateActionFlow(row: row, col: col, selectedCharacter: draggedCharacter)
                                                draggedCharacter = emptyCharacter
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    
                    PlayerStatusView(
                        image: gameStatus.mainPlayer.image,
                        bloodPoint: $gameStatus.mainPlayer.bloodPoint,
                        manaPoint: $gameStatus.mainPlayer.manaPoint,
                        manaPositionTop: true,
                        showDeck: true,
                        draggedCharacter: $draggedCharacter,
                        player: $gameStatus.mainPlayer,
                        playerTurn: $gameStatus.playerTurn,
                        displayCharacterDeck: $gameStatus.mainPlayer.displayCharacterDeck,
                        showLoading: false,
                        gameStatus: gameStatus
                    )
                }
            }
            .onChange(of: self.gameStatus.playerTurn, perform: { (value) in
                if self.gameStatus.playerTurn == self.gameStatus.botPlayer{
                    self.gameStatus.botLoading()
                }
            })
            .edgesIgnoringSafeArea(.all)
    }
}

class GameStatus: ObservableObject {
    @Published var level: GameLevel = .easy
    @Published var mainBoard: MainBoard = MainBoard()
    @Published var mainPlayer: PlayerGame = PlayerGame(color: .brown)
    @Published var playerTurn: PlayerGame  = PlayerGame(
        color: .clear)
    @Published var botPlayer: PlayerGame = PlayerGame(color: .purple)
    @Published var turn = 0
    
    init(){
        self.playerTurn = botPlayer
        if self.playerTurn == botPlayer{
            self.botLoading()
        }
        
    }
    
    func botLoading () {
        // Bot turn
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            self.botProcess()
        }
    }
    
    func updateActionFlow(row: Int, col: Int, selectedCharacter: Character){
        turn = turn + 1
        var waitingTime = 3
        
        self.removePlayerDeck(removedCharacter: selectedCharacter)
        self.addCharacterInCell(row: row, col: col, selectedCharacter: selectedCharacter)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(waitingTime)){ [self] in
            // Update existing character and minus point
            if turn >= 2 {
                turn = 0
                var flatMainBoard = mainBoard.cells.flatMap { $0 }
                
                var mainPlayerBloodReduced = flatMainBoard
                    .filter { $0.isBlockedBy?.id == botPlayer.id }
                    .map({$0.character.attackPoint}).reduce(0, +)
                self.mainPlayer.updatePlayerStatus(manaPoint: 1, bloodPoint: -mainPlayerBloodReduced)
                
                var mainBotBloodReduced = flatMainBoard
                    .filter { $0.isBlockedBy?.id == mainPlayer.id }
                    .map({$0.character.attackPoint}).reduce(0, +)
                self.botPlayer.updatePlayerStatus(manaPoint: 1, bloodPoint: -mainBotBloodReduced)
                
                // increase waiting time to do animation update Blood point
                waitingTime += 2
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(waitingTime)) { [self] in
            self.playerTurn = self.playerTurn.id == self.botPlayer.id ? mainPlayer : botPlayer
        }
    }
    
    func botProcess(){
        // process AI deck with point
        // filter the current card with less mana than the bot
        let availableDecks = botPlayer.displayCharacterDeck.filter { character in
            character.manaPoint < botPlayer.manaPoint
        }
        // Check available deck and random whether should spend mana to buy
        if availableDecks.isEmpty{
            return
        }

        let selectedCharacter = availableDecks[0]
        let emptyCells = twoDArrayToColumnAndRowTuplesWithFilter(mainBoard.cells)
        
        // No empty cells
        if emptyCells.isEmpty {
            return
        }
        
        let selectedCellTuple = emptyCells[Int.random(in: 0..<emptyCells.count)]
        updateActionFlow(row: selectedCellTuple.1, col: selectedCellTuple.0, selectedCharacter: selectedCharacter)
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
            var cell = self.mainBoard.cells[col][row]
            if cell.character.bloodPoint < selectedCharacter.attackPoint{
                
            }
            self.mainBoard.cells[col][row].isDead = true
        }
    }
}
    
    


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameStatus: GameStatus())
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(DataController())
            .environmentObject(CurrentPlayer())
    }
}
