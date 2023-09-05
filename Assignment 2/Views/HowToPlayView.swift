/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 18/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import Foundation
import SwiftUI

struct HowToPlay: View {
    @EnvironmentObject var gameSettings: GameSettings
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack (alignment: .trailing){
            gameSettings.menuTheme.topLevelColor
            ScrollView {//use scroll view for the tutorial
                VStack{
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .menuPage
                        }}) {
                            Text("< Go Back")
                                .underline()
                        }
                        .padding(.top, 50)
                        .padding(.horizontal, 30)
                    
                    Text("Player Turns")
                        .bold()
                        .modifier(HeadingModifier())
                    Text(turns)
                        .modifier(HeadingModifier())
                    
                    Text("Battle field")
                        .bold()
                        .modifier(HeadingModifier())
                    HStack{
                        Text(battle_field)
                            .modifier(HeadingModifier())
                        Image("battle_field")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Text("Card")
                        .bold()
                        .modifier(HeadingModifier())
                    HStack{
                        Text(card)
                            .modifier(HeadingModifier())
                        Image("card")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    
                    Text("How character helps defeats opponent in battle")
                        .bold()
                        .modifier(HeadingModifier())
                    HStack{
                        Text(attack)
                            .modifier(HeadingModifier())
                        Image("cell_attack")
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Text(goal)
                        .bold()
                        .modifier(HeadingModifier())
                    
                }.padding(10)
            }
            
        }
    }
}

struct HowToPlay_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlay()
    }
}
