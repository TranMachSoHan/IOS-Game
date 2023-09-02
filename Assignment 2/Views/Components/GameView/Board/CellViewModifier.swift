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

struct AttackCellModifier: ViewModifier {
    let state: Binding<Bool>
    @Binding var cell: Cell
    @State var playerTurn: PlayerGame = PlayerGame(color: .blue)
    let repeatCount: Int
    let duration: Double
    @EnvironmentObject var gameSettings: GameSettings
    
    // internal wrapper is needed because there is no didFinish of Animation now
    private var blinking: Binding<Bool> {
        Binding<Bool>(get: {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.duration) {
                self.state.wrappedValue = false
            }
            return self.state.wrappedValue }, set: {
            self.state.wrappedValue = $0
        })
    }
    
    func body(content: Content) -> some View
    {
        ZStack{
            cell.isBlockedBy != nil ? cell.isBlockedBy?.color : gameSettings.menuTheme.boardColor
            
            Color(self.blinking.wrappedValue ? .purple : .clear)
                .animation( // Kind of animation can be changed per needs
                    Animation.linear(duration:self.duration).repeatCount(self.repeatCount)
                )
            
            if (cell.character.characterName != ""){
                CharacterCell(character: $cell.character, cell: $cell)
            }
        }
    }
}

extension View {
    func attackCell(state: Binding<Bool>, cell: Binding<Cell>,
                     repeatCount: Int = 1, duration: Double = 0.5) -> some View {
        self.modifier(AttackCellModifier(state: state, cell: cell,
                                             repeatCount: repeatCount, duration: duration))
    }
}

struct CellViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameStatus: GameStatus())
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(DataController())
            .environmentObject(CurrentPlayer())
            .environmentObject(GameSettings())
    }
}

