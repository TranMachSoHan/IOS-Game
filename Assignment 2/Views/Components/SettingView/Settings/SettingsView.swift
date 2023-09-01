import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var gameSettings: GameSettings

    var body: some View {
        ZStack{
            gameSettings.menuTheme.topLevelColor
            
            VStack(alignment: .leading, spacing: 30) {
                // Dark Mode Toggle
                HStack{
                    Text("DarkMode")
                        .modifier(HeadingModifier())
                    DarkmodeToggle(darkmode: $gameSettings.darkMode)
                }
                
                // Language
                VStack (alignment: .leading){
                    Text("Language")
                        .modifier(HeadingModifier())
                    HStack {
                        ForEach(Locale.allCases, id: \.self) { lang in
                            SettingSelect(isSelected: .constant(gameSettings.locale == lang), text: lang.rawValue.capitalized)
                                .onTapGesture {
                                    gameSettings.locale = lang
                                }
                        }
                    }
                }
                
                // Difficulty Mode
                VStack (alignment: .leading){
                    Text("Difficulty Mode")
                        .modifier(HeadingModifier())
                    HStack {
                        ForEach(DifficultyMode.allCases, id: \.self) { mode in
                            SettingSelect(isSelected: .constant(gameSettings.difficultyMode == mode), text: mode.rawValue.capitalized)
                                .onTapGesture {
                                    gameSettings.difficultyMode = mode
                                }
                        }
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                            .fill(gameSettings.menuTheme.fourthLevelColor.opacity(0.2))
                            .frame(height: 200)
                        Text(gameSettings.modeDescription)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(gameSettings.menuTheme.fourthLevelColor)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 100)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// Will be moved to the components

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


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(GameSettings())
    }
}
