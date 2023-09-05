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
    @Binding var player: PlayerGame
    @Binding var playerTurn: PlayerGame
    @Binding var isMainPlayerTurn: Bool
    @State var showLoading: Bool
    @State var gameStatus: GameStatus
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var currentPlayer: CurrentPlayer
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    @State var leftOffset: CGFloat = -80
    @State var rightOffset: CGFloat = 80
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Spacer()
                    HStack{
                        image
                            .resizable()
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(playerTurn.id == player.id ? player.color : .white, lineWidth: geo.size.height/10)
                            )
                            .shadow(radius: 7)
                            .frame(width: geo.size.width/2, height: geo.size.height/1.5)
                        
                        Rectangle()
                            .fill(.opacity(0))
                            .frame(width: geo.size.width/2, height: geo.size.height/4)
                            .overlay {
                                if showLoading{
                                    if gameStatus.playerTurn.id == gameStatus.botPlayer.id{
                                        LoadingView()
                                        .frame(width: geo.size.width/2)
                                    }
                                    else{
                                        
                                    }
                                }
                                else{
                                    if isMainPlayerTurn{
                                        Button(action: {
                                            gameStatus.updateNextPlayer()
                                            MusicPlayer.shared.playSoundEffect(soundEffect: "end-turn", type: "mp3")
                                            isMainPlayerTurn = false
                                            dismiss()
                                        }) {
                                            HStack {
                                                Text("End Turn")
                                                    .fontWeight(.semibold)
                                            }
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .padding()
                                            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                                            .cornerRadius(40)
                                        }
                                    }
                                    
                                }
                            }
                    }
                    .frame(height: geo.size.height/7)
                    
                    BloodBarView(percentage: $bloodPoint, originBloodPoint: bloodPoint)
                        .frame(height: geo.size.height/7)
                        .padding(.horizontal, geo.size.width/15)
                    
                    manaBar
                        .frame(height: geo.size.height/10)
                        .padding(.vertical, geo.size.height/10)
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
