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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: upAttack ?  "chevron.up.circle" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Image(systemName: leftAttack ?  "chevron.left.circle" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Spacer()
                        Image(systemName: rightAttack ?  "chevron.right.circle" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                    }
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: downAttack ?  "chevron.down.circle" : "")
                            .resizable()
                            .foregroundColor(.yellow)
                            .frame(width: geo.size.width/6, height: geo.size.height/9)
                            .font(Font.title.weight(.heavy))
                        Spacer()
                    }
                }
            }
        }
    }
}
