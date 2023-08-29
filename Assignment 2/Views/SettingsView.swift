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

            Text(gameSettings.modeDescription)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 300, height: 200)
                .background(Rectangle().foregroundColor(Color.black.opacity(0.5)))
            
            // Language
            
        }
        .padding(.horizontal, 20)
    }
}

// Will be moved to the components 
struct ModeItem: View {
    @EnvironmentObject var gameSettings: GameSettings
    var modeItem: DifficultyMode
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                    .fill(gameSettings.difficultyMode == modeItem  ? gameSettings.menuTheme.thirdLevelColor : Color.secondLevelColor)
                Text(modeItem.rawValue.capitalized)
                    .font(.system(size: 15.0))
                    .foregroundColor(
                         gameSettings.difficultyMode == modeItem ? gameSettings.menuTheme.topLevelColor  : gameSettings.menuTheme.fourthLevelColor
                     )
        }
        .onTapGesture {
            gameSettings.difficultyMode = modeItem
        }
    }
}

struct LocalePicker: View {
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
                    .fill(gameSettings.menuTheme.thirdLevelColor)
            )
            Text("Language")
                .foregroundColor(gameSettings.menuTheme.secondLevelColor)
                .padding()
        }
    }
}
