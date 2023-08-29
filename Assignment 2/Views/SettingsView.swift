import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var gameSettings: GameSettings

    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")

            // Dark Mode Toggle 
            DarkModeToggleView(darkMode: $gameSettings.darkMode)
                .onTapGesture {
                    withAnimation(Animation.easeIn){
                        gameSettings.darkmode.toggle()
                    }
                }

            // Difficulty Mode 
            HStack(spacing: 20) {
                ForEach(Mode.allCases, id: \.self) { mode in
                    ModeItem(modeItem: mode)
                }
            }

            // Language
            
        }
    }
}

// Will be moved to the components 
struct ModeItem: View {
    @EnvironmentObject var gameSettings: GameSettings
    var modeItem: Mode
    
    var body: some View {
        ZStack {
            // Color(gameSettings.mode == modeItem  ? gameSettings.theme.buttonYellow : Color.clear)
            
            Text(modeItem.rawValue)
                .font(.system(size: 15.0))
                // .foregroundColor(
                //     gameSettings.mode == modeItem ? gameSettings.theme.red  : .black
                // )

            RoundedRectangle(cornerRadius: 25)
                .fill(gameSettings.mode == modeItem  ? gameSettings.theme.buttonYellow : Color.clear)
        }
        .onTapGesture {
            gameSettings.mode = modeItem
        }
    }
}

struct ThemePicker: View {
    @EnvironmentObject var gameSettings: GameSettings
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Picker("", selection: $gameSettings.locale) {
                ForEach(Locale.allCases, id: \.self) {
                    Text($0.rawValue.capitalized).tag($0)
                }
            }
            .pickerStyle(InlinePickerStyle())
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(gameSettings.theme.buttonYellow)
            )
            Text("Language")
                .foregroundColor(.white)
                .padding()
        }
    }
}
