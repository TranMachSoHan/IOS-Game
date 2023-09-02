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
    https://seons-dev.tistory.com/entry/Stack-%EC%A1%B0%ED%95%A9
    https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
*/

import SwiftUI

struct CharacterDeck: View {
    var image : Image
    var attackPoint: Int
    var manaPoint: Int
    var bloodPoint: Int
    var upAttack: Bool
    var downAttack: Bool
    var rightAttack: Bool
    var leftAttack: Bool
    var leftUpAttack: Bool
    var leftDownAttack: Bool
    var rightUpAttack: Bool
    var rightDownAttack: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack (alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(gradient: Gradient(colors: [.black, .red, .yellow]), startPoint: .top, endPoint: .bottom))

                ZStack{
                    characterImg
                }.padding(10)
                VStack {
                    HStack{
                        StatusPoint(point: manaPoint, image: Image("mana"))
                            .frame(height: geo.size.height/4)
                        Spacer()
                    }
                    Spacer()
                    HStack{
                        StatusPoint(point: attackPoint, image: Image("attack"))
                            .frame(height: geo.size.height/4)
                        StatusPoint(point: bloodPoint, image: Image("blood"))
                            .frame(height: geo.size.height/4)
                    }
                }
            }
            .padding(.vertical, geo.size.height/14)
            .padding(.horizontal, geo.size.width/8)
            
            DirectionView(
                upAttack: upAttack,
                downAttack: downAttack,
                rightAttack: rightAttack,
                leftAttack: leftAttack,
                leftUpAttack: leftUpAttack,
                leftDownAttack: leftDownAttack,
                rightUpAttack: rightUpAttack,
                rightDownAttack: rightDownAttack)
        }
    }
}

extension CharacterDeck {
    var characterImg : some View{
        ZStack{
            image
                .resizable()
                .clipShape(Ellipse())
                .overlay(
                    Ellipse()
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center),
                            lineWidth: 4))
                .shadow(radius: 7)
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

struct CharacterDeck_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDeck(image: Image("knight"), attackPoint: 3, manaPoint: 1, bloodPoint: 1, upAttack: true, downAttack: true, rightAttack: true, leftAttack: true, leftUpAttack: true,
                      leftDownAttack: true,
                      rightUpAttack: true,
                      rightDownAttack: true)
    }
}
