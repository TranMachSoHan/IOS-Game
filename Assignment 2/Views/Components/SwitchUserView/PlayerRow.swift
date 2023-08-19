//
//  PlayerRow.swift
//  Assignment 2
//
//  Created by macOS on 19/08/2023.
//

import SwiftUI

struct PlayerRow: View {
    var player: Player
    
    var body: some View {
        VStack {
            Image(player.imageName!)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(0.5)
            Text(player.name!)
        }
    }
}
