/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 31/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import SwiftUI

struct SettingSelect: View {
    @EnvironmentObject var gameSettings: GameSettings
    @Binding var isSelected: Bool
    @State var text: String
    var body: some View {
        ZStack {
            //a button in setting view for select level og game
            Capsule()
                .frame(height: 50)
                .foregroundColor(isSelected ? gameSettings.menuTheme.thirdLevelColor : gameSettings.menuTheme.thirdLevelColor.opacity(0.3))
            Text(text)
                .foregroundColor(
                    isSelected ?
                    gameSettings.menuTheme.topLevelColor :
                        gameSettings.menuTheme.thirdLevelColor)
        }
    }
}

struct SSettingSelect_Previews: PreviewProvider {
    static var previews: some View {
        SettingSelect(isSelected: .constant(false), text: "option")
            .environmentObject(GameSettings())
    }
}
