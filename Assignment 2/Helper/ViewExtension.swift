//
//  ViewExtension.swift
//  Assignment 2
//
//  Created by macOS on 14/08/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
