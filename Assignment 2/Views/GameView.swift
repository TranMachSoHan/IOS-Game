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
*/


import SwiftUI

struct GameView: View {
    private var gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                //Background
                Image("game-background-1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack {
                    LazyVGrid(columns: gridItemLayout) {
                        ForEach((0...15), id: \.self) {_ in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: geo.size.height/7)
                        }
                    }.padding(.horizontal, 15)
                    HStack {
                        ParentDeck(systemName: "hammer.fill")
                            .frame(width: geo.size.width/6, height: geo.size.height/7)
                        Spacer()
                        HStack {
                            ForEach((0...2), id: \.self) {_ in
                                ParentDeck(systemName: "hammer.fill")
                                    .frame(width: geo.size.width/6, height: geo.size.height/7)
                            }
                        }
                    }.padding(.top, 30)
                }.padding(.horizontal, 10)
            }
            
        }
    }
    
}

extension GameView {
    var playerCard : some View {
        HStack {
            
        }
    }
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
