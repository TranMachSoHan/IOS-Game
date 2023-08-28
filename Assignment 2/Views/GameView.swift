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

var characterExample = ["knight", "samurai", "robin-hood"]

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
                    HStack {
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
                            isOpponentLoading: $gameStatus.isLoading
                        )
                    }
                    
                    ForEach(0..<4, id: \.self) { row in
                        HStack {
                            ForEach(0..<4, id: \.self) { col in
                                CellCharacterStatusView(cell: $gameStatus.mainBoard.cells[col][row], draggedCharacter: $draggedCharacter)
                                    .onTapGesture {
                                        withAnimation {
                                            if draggedCharacter.characterName != "" {
//                                                gameStatus.mainBoard.cells[col][row].character = draggedCharacter
                                                gameStatus.addCharacterInCell(row: row, col: col, selectedCharacter: draggedCharacter)
                                                
                                                gameStatus.removePlayerDeck(removedCharacter: draggedCharacter)
                                                
                                                gameStatus.updatePlayerTurn(player: gameStatus.botPlayer)
                                                draggedCharacter = emptyCharacter
                                                self.gameStatus.botLoading()
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    
                    HStack {
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
                            isOpponentLoading: $gameStatus.isLoading
                        )
                    }
                }
                .padding(.horizontal, 10)
            }
            .onAppear(){
                self.gameStatus.intialGame()
                self.gameStatus.botLoading()
            }
    }
    
    
    
}

class GameStatus: ObservableObject {
    @Published var level: GameLevel = .easy
    @Published var mainBoard: MainBoard = MainBoard()
    @Published var mainPlayer: PlayerGame = PlayerGame(color: .green)
    @Published var playerTurn: PlayerGame  = PlayerGame(color: .clear)
    @Published var botPlayer: PlayerGame = PlayerGame(color: .red)
    @Published var isLoading = false
    
    func botLoading () {
        // Bot turn
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [self] in
//            self.botProcess()
//            self.updatePlayerTurn(player: mainPlayer)
//            isLoading = false
//        }
        
        self.botProcess()
        self.updatePlayerTurn(player: mainPlayer)
        isLoading = false
    }
    
    func updatePlayerTurn(player: PlayerGame){
        playerTurn = player
    }
    
    func intialGame(){
        updatePlayerTurn(player: botPlayer)
        self.isLoading = self.playerTurn == self.botPlayer
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
        addCharacterInCell(row: selectedCellTuple.1, col: selectedCellTuple.0, selectedCharacter: selectedCharacter)
        removePlayerDeck(removedCharacter: selectedCharacter)
    }
    
    func removePlayerDeck(removedCharacter: Character){
        if playerTurn == botPlayer {
            self.botPlayer.removeDeck(removedCharacter: removedCharacter)
        }
        else {
            self.mainPlayer.removeDeck(removedCharacter: removedCharacter)
        }
    }
    
    func twoDArrayToColumnAndRowTuplesWithFilter(_ array: [[Cell]]) -> [(Int, Int)] {
        return array.enumerated().flatMap { (index, row) in
            row.enumerated().filter { $0.element.character.characterName == "" }.map { ($0.offset, index) }
        }
    }
    
    func getAttackedCells(){
        
    }
    
    func addCharacterInCell(row: Int, col: Int, selectedCharacter: Character){
        self.mainBoard.cells[col][row].character = selectedCharacter
        if playerTurn == botPlayer {
            self.botPlayer.updatePlayerStatus(manaPoint: selectedCharacter.manaPoint)
        }
        else {
            self.mainPlayer.updatePlayerStatus(manaPoint: selectedCharacter.manaPoint)
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
