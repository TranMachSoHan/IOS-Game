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

struct CharacterCell: View {
    @Binding var character: Character
    @Binding var cell: Cell

    var body: some View {
        ZStack {
            arrowCell
            VStack {
                character.imageChibi
                    .resizable()
                    .animation(.easeIn(duration: 0.5))
                HStack (alignment: .bottom){
                    StatusPoint(point: character.attackPoint, image: Image("attack"))
                        .frame(width: 20, height: 20)
                    StatusPoint(point: character.bloodPoint, image: Image("blood"))
                        .frame(width: 20, height: 20)
                }
            }
            .padding(7)
        }
        .onChange(of: cell.isDead, perform: { (value) in
            withAnimation(.easeInOut(duration: 0.5).delay(0.4)) {
                cell.isDead = false
                character.characterName = ""
                cell.isBlockedBy = nil
            }
        })
    }
}

extension CharacterCell {
    
    var arrowCell : some View{
        VStack {
            HStack {
                Spacer()
                if (character.upAttack){
                    Image(systemName: "arrow.up")
                        .foregroundColor(.green)
                }
                Spacer()
            }
            Spacer()
            HStack {
                if (character.leftAttack){
                    Image(systemName: "arrow.left")
                        .foregroundColor(.green)
                }
                else{
                    Spacer()
                }
                Spacer()
                if (character.rightAttack){
                    Image(systemName: "arrow.right")
                        .foregroundColor(.green)
                }
                else{
                    Spacer()
                }
            }
            Spacer()
            HStack {
                Spacer()
                if (character.downAttack){
                    Image(systemName: "arrow.down")
                        .foregroundColor(.green)
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

struct CharacterCellView: PreviewProvider {
    static var previews: some View {
        GameView(gameStatus: GameStatus())
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(DataController())
            .environmentObject(CurrentPlayer())
    }
}

