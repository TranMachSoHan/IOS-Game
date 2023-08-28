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

import SwiftUI

var characterMainDeck = [
    Character(characterName: "knight", manaPoint: 3, bloodPoint: 2, attackPoint: 1),
    Character(characterName: "samurai", manaPoint: 1, bloodPoint: 2, attackPoint: 1),
    Character(characterName: "robin-hood", manaPoint: 2, bloodPoint: 2, attackPoint: 1)
]
struct PlayerStatusView: View {
    var image: Image
    @Binding var bloodPoint: Int
    @Binding var manaPoint: Int
    @State var manaPositionTop: Bool
    @State var showDeck: Bool
    @Binding var draggedCharacter: Character
    @Binding var player: PlayerGame
    @Binding var playerTurn: PlayerGame
    @Binding var displayCharacterDeck: [Character]
    @State var showLoading: Bool
    @Binding var isOpponentLoading: Bool
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    @State var leftOffset: CGFloat = -80
    @State var rightOffset: CGFloat = 80
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(playerTurn == player ? "background-player-turn" : "background-player")
                VStack {
                    if manaPositionTop {
                        manaBar
                            .frame(height: geo.size.height/5)
                    }
                    HStack {
                        ZStack (alignment: .bottom){
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(.white), lineWidth: 4))
                                .shadow(radius: 7)
                            
                            BloodBarView(percentage: $bloodPoint)
                                .frame(height: geo.size.height/10)
                        }
                        
                        if showDeck {
                            ForEach(displayCharacterDeck, id: \.self) {character in
                                CharacterDeck(image: Image(character.characterName), attackPoint: character.attackPoint, manaPoint: character.manaPoint, bloodPoint: character.bloodPoint)
                                    .onTapGesture {
                                        if playerTurn == player && player.manaPoint >= character.manaPoint{
                                            draggedCharacter = draggedCharacter == character ? emptyCharacter : character
                                        }
                                    }
                                    .border(.green, width: draggedCharacter == character ? 10 : 0)
                            }
                        }
                        if showLoading{
                            Spacer()
                            if isOpponentLoading{
                                ZStack{
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: 20)
                                        .offset(x: leftOffset)
                                        .opacity(0.7)
                                        .animation(Animation.easeInOut(duration: 1))
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: 20)
                                        .offset(x: leftOffset)
                                        .opacity(0.7)
                                        .animation(Animation.easeInOut(duration: 1).delay(0.2))
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: 20)
                                        .offset(x: leftOffset)
                                        .opacity(0.7)
                                        .animation(Animation.easeInOut(duration: 1).delay(0.4))
                                }
                                .onReceive(timer) { (_) in
                                    swap(&self.leftOffset, &self.rightOffset)
                                }
                                .frame(width: geo.size.width/2)
                            }
                        }
                    }
                    
                    if !manaPositionTop{
                        manaBar
                            .frame(height: geo.size.height/5)
                    }
                }
            }
        }
    }
}

extension PlayerStatusView {
    var manaBar : some View {
        ManaBarView(manaPoint: $manaPoint)
//            .padding(manaPositionTop ? .bottom : .top, 30)
    }
}

//
//struct PlayerStatusView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerStatusView(image: Image("luckin317"), bloodPoint: 40)
//            .environmentObject(GameSettings())
//    }
//}
