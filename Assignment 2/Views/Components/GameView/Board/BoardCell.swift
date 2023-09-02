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

import SwiftUI

struct BoardCell: View {
    @Binding var draggedCharacter: Character
    @ObservedObject var gameStatus: GameStatus
    
    var body: some View {
        ForEach(0..<4, id: \.self) { row in
            HStack {
                ForEach(0..<4, id: \.self) { col in
                    CellCharacterStatusView(cell: $gameStatus.mainBoard.cells[col][row], draggedCharacter: $draggedCharacter)
                        .onTapGesture {
                            withAnimation {
                                if draggedCharacter.characterName != "" {
                                    gameStatus.updateActionFlow(row: row, col: col, selectedCharacter: draggedCharacter)
                                    MusicPlayer.shared.playSoundEffect(soundEffect: "character-drag", type: "mp3")
                                    draggedCharacter = emptyCharacter
                                }
                            }
                        }
                }
            }
        }
    }
}


//struct CharacterCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterCell(character: Character(characterName: "knight", manaPoint: 3, bloodPoint: 2, attackPoint: 1))
//    }
//}
