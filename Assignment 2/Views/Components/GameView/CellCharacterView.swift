//
//  CellCharacterView.swift
//  Assignment 2
//
//  Created by macOS on 14/08/2023.
//

import SwiftUI

struct CellCharacterView: View {
    var character: CharacterTest = CharacterTest()
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.gray)
            .frame(width: 60, height: 60)
            .padding(5)

    }
}

struct CellCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CellCharacterView()
    }
}

