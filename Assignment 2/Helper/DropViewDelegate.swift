//
//  DropViewDelegate.swift
//  Assignment 2
//
//  Created by macOS on 14/08/2023.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    let destinationItem: Color
    @Binding var colors: [Color]
    @Binding var draggedItem: Color?
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
}
