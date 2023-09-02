//
//  DirectionView.swift
//  Assignment 2
//
//  Created by macOS on 31/08/2023.
//

import SwiftUI

struct DirectionView: View{
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
            ZStack {
                VStack{
                    HStack{
                        Image(systemName: leftUpAttack ?  "arrow.up.left.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Image(systemName: upAttack ?  "arrow.up.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Image(systemName: rightUpAttack ?  "arrow.up.right.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                    }
                    Spacer()
                    HStack {
                        Image(systemName: leftAttack ?  "arrow.left.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Spacer()
                        Image(systemName: rightAttack ?  "arrow.right.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                    }
                    
                    Spacer()
                    HStack {
                        Image(systemName: leftDownAttack ?  "arrow.down.left.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Image(systemName: downAttack ?  "arrow.down.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Image(systemName: rightDownAttack ?  "arrow.down.right.circle.fill" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                    }
                }
            }
        }
    }
}
