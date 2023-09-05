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
        GeometryReader { geo in
            ZStack (alignment: .center) {
                VStack (alignment: .center){
                    character.imageChibi
                        .resizable()
                        .animation(.easeIn(duration: 0.5))
                        .frame(width: geo.size.width/1.3)
                    HStack{
                        Spacer()
                        StatusPoint(point: character.attackPoint, image: Image("attack"))
                            .frame(width: geo.size.width/3, height: geo.size.height/3)
                        StatusPoint(point: character.bloodPoint, image: Image("blood"))
                            .frame(width: geo.size.width/3, height: geo.size.height/3)
                        Spacer()
                    }
                }
            }
            .padding(.vertical, geo.size.height/9)
            .onChange(of: cell.isDead, perform: { (value) in
                withAnimation(.easeInOut(duration: 0.5).delay(0.4)) {
                    cell.isDead = false
                    character.characterName = ""
                    cell.isBlockedBy = nil
                }
            })
            
            DirectionView(
                upAttack: character.upAttack,
                downAttack: character.downAttack,
                rightAttack: character.rightAttack,
                leftAttack: character.leftAttack,
                leftUpAttack: character.leftUpAttack,
                leftDownAttack: character.leftDownAttack,
                rightUpAttack: character.rightUpAttack,
                rightDownAttack: character.rightDownAttack)
        }
    }
}

struct CharacterCellView: PreviewProvider {
    static var previews: some View {
        GameView(isNewGame: true, gameStatus: GameStatus(gameProgress: nil))
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(DataController())
            .environmentObject(CurrentPlayer())
    }
}

