/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 07/08/2023
  Last modified: 02/09/2023
  Acknowledgement: 
    - Toggle Animation: https://github.com/Inncoder/SwiftUI-Animations/blob/master/Animations/DarkmodeToggle/DarkmodeToggle.swift
*/

import SwiftUI

struct DarkModeToggleView: View {
    
    @Binding var darkmode: Bool
    
    var body: some View {
        ZStack {
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 15, y: 0)
                .opacity(darkmode ? 0 : 1)
            Image(systemName: "cloud.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 15, height: 10)
                .offset(x: 30, y: 10)
                .opacity(darkmode ? 0 : 1)
            
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -20, y: -12)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -5, y: -5)
                .opacity(darkmode ? 1 : 0)
            Image(systemName: "star.fill")
                .resizable()
                .foregroundColor(.yellow)
                .frame(width: 5, height: 5)
                .offset(x: -25, y: 10)
                .opacity(darkmode ? 1 : 0)
        }
    }
}
