//
//  StatusPoint.swift
//  Assignment 2
//
//  Created by macOS on 10/08/2023.
//

import SwiftUI

struct StatusPoint: View {
    var point: Int
    var image: Image
    
    var body: some View {
        GeometryReader{g in
            ZStack {
                image
                    .resizable()
                    .scaledToFit()
                Text("\(point)")
                    .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.6: g.size.height * 0.6))
                    .foregroundColor(.white)
            }
        }
    }
}

struct StatusPoint_Previews: PreviewProvider {
    static var previews: some View {
        StatusPoint(point: 2, image: Image("blood"))
    }
}
