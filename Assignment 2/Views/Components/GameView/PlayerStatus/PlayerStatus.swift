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
    @State var gameStatus: GameStatus
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    @State var leftOffset: CGFloat = -80
    @State var rightOffset: CGFloat = 80
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    if manaPositionTop {
                        manaBar
                            .frame(height: geo.size.height/10)
                            .padding(.vertical, geo.size.height/10)
                    }
                    HStack{
                        image
                            .resizable()
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(playerTurn.id == player.id ? player.color : .white, lineWidth: 10))
                            .shadow(radius: 7)
                            .frame(height: geo.size.height/2)
                        
                        if showLoading{
                            if playerTurn.id == gameStatus.botPlayer.id{
                                LoadingView()
                                .frame(width: geo.size.width/2)
                            }
                            else{
                                Rectangle()
                                    .fill(.opacity(0))
                                    .frame(width: geo.size.width/2, height: geo.size.height/5)
                            }
                        }
                        else{
                            if playerTurn.id == gameStatus.mainPlayer.id{
                                Button(action: {
                                    print("Share tapped!")
                                }) {
                                    HStack {
                                        Text("End Turn")
                                            .fontWeight(.semibold)
                                            .onTapGesture {
                                                gameStatus.updateNextPlayer()
                                                MusicPlayer.shared.playSoundEffect(soundEffect: "end-turn", type: "mp3")
                                                dismiss()
                                            }
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(40)
                                }
                            }
                            
                        }
                    }
                    .frame(height: geo.size.height/7)
                    
                    BloodBarView(percentage: $bloodPoint, originBloodPoint: bloodPoint)
                        .frame(height: geo.size.height/15)
                    if showDeck {
                        HStack {
                            ForEach(displayCharacterDeck, id: \.self) {character in
                                CharacterDeck(
                                    image: Image(character.characterName),
                                    attackPoint: character.attackPoint,
                                    manaPoint: character.manaPoint,
                                    bloodPoint: character.bloodPoint,
                                    upAttack: character.upAttack,
                                    downAttack: character.downAttack,
                                    rightAttack: character.rightAttack,
                                    leftAttack: character.leftAttack,
                                    leftUpAttack: character.leftUpAttack,
                                    leftDownAttack: character.leftDownAttack,
                                    rightUpAttack: character.rightUpAttack,
                                    rightDownAttack: character.rightDownAttack
                                )
                                .onTapGesture {
                                    if playerTurn.id == player.id && player.manaPoint >= character.manaPoint{
                                        draggedCharacter = draggedCharacter == character ? emptyCharacter : character
                                    }
                                }
                                .border(.green, width: draggedCharacter == character ? 10 : 0)
                            }
                        }
                    }
                    
                    if !manaPositionTop{
                        manaBar
                            .frame(height: geo.size.height/10)
                            .padding(.vertical, geo.size.height/10)
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
