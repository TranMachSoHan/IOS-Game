import SwiftUI

struct SettingsView: View {
    @ObservedObject var gameSettings: GameSettings

    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
            DarkModeToggleView(darkMode: $gameSettings.darkMode)
                .onTapGesture {
                    withAnimation(Animation.easeIn){
                        gameSettings.darkmode.toggle()
                    }
                }
                
        }
    }
}
