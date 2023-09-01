//
//  CustomTextViewModifier.swift
//  Assignment 2
//
//  Created by macOS on 31/08/2023.
//

import SwiftUI

struct HeadingModifier: ViewModifier {
    @EnvironmentObject var gameSettings: GameSettings
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Open Sans", size: 25))
            .foregroundColor(gameSettings.menuTheme.fourthLevelColor)
    }
}

extension Text {
    func customText() -> some View {
        self.strikethrough().bold().italic().lineLimit(4)
            .modifier(HeadingModifier())
    }
}
