/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 28/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
 https://stackoverflow.com/questions/59015929/button-blink-animation-with-swiftui

*/


import SwiftUI

struct CellCharacterStatusView: View {
    @Binding var cell: Cell
    @Binding var draggedCharacter: Character

    var body: some View {
        let color_switch: Bool = draggedCharacter.characterName != "" && cell.character.characterName == ""
        GeometryReader { geo in
            ZStack{}
                .attackCell(state: $cell.isAttackedCell, cell: $cell, repeatCount: 10, duration: 0.2)
                .border(color_switch ? .yellow: .clear, width: color_switch ? 3: 0)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
        }
        
    }

}

struct CellCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(isNewGame: true, gameStatus: GameStatus(gameProgress: nil))
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(DataController())
            .environmentObject(CurrentPlayer())
    }
}

