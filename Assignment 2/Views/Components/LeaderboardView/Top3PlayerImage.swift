/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 23/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
 https://adrianhall.github.io/swift/2020/05/03/swiftui-masks/
 
*/

import SwiftUI
struct Top3PlayerImage: View {
    @State var player: Player
    @State var topPosition: Bool = true
    
    var body: some View{
        VStack{
            if (topPosition) {
                Image(player.imageName!)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(0.5)
                    .overlay(alignment: .bottom) {
                        Rectangle().frame(minHeight: 0, maxHeight: 10)
                    }
            }
            Text(player.name!)
            Text("\(player.score)")
        }
    }
}
