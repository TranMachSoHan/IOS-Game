/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 09/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://www.pinterest.com/imabamfyo/game-ui-splash-welcome-screens/
    https://stackoverflow.com/questions/56443535/swiftui-text-alignment
    https://www.pinterest.com/pin/451134087689536109/
    https://www.pinterest.com/pin/701154235755448104/
    https://www.besthdwallpaper.com/cuoi-lon/knight-zed-splash-art-lien-minh-huyen-thoai-lol-dt_vi-64746.html
    https://www.freepik.com/premium-photo/scary-black-werewolf-illustration-full-body-3d-rendering_33092555.htm
    https://blog.canopas.com/reorder-items-with-drag-and-drop-using-swiftui-e336d44b9d02
 
*/


import SwiftUI

var characterExample = ["knight", "samurai", "robin-hood"]
var characterMainDeck = [
    CharacterTest(characterName: "knight", manaPoint: 3, bloodPoint: 2, attackPoint: 1),
    CharacterTest(characterName: "samurai", manaPoint: 1, bloodPoint: 2, attackPoint: 1),
    CharacterTest(characterName: "robin-hood", manaPoint: 2, bloodPoint: 2, attackPoint: 1)
]
var emptyCharacter : CharacterTest = CharacterTest()

var emptyCell : CellTest = CellTest(Character: emptyCharacter)

struct GameView: View {
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var dataController: DataController
    @State var draggedCharacter: CharacterTest = emptyCharacter
    @State var levelStatus  : LevelStatus = LevelStatus()
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                //Background
                Image("game-background-1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack {
                    HStack {
                        PlayerStatusView(image: Image("robot"))
                            .frame(height: geo.size.height/4)
                    }
                    ManaBarView(manaPoint: 3)
                        .frame(height: geo.size.height/40)
                        .padding(.bottom, 30)
//                    ForEach(levelStatus.mainBoard?.allObjects as! [Cell], id: \.self) { cell in
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(.gray)
//                            .frame(width: 60, height: geo.size.height/10)
//                            .padding(5)
//                    }
                    
                    ForEach(0..<3, id: \.self) { row in
                        HStack {
                            ForEach(0..<3, id: \.self) { col in
                                let character = CharacterTest()
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.gray)
                                    .frame(width: 60, height: geo.size.height/10)
                                    .padding(5)
                            }
                        }
                    }
                    
                    ManaBarView(manaPoint: 3)
                        .frame(height: geo.size.height/40)
                        .padding(.top, 30)
                    
                    HStack {
                        PlayerStatusView(image: Image("luckin317"))
                            .frame(height: geo.size.height/7)
                        ForEach(characterMainDeck, id: \.self) {character in
                            CharacterDeck(image: Image(character.characterName), attackPoint: character.attackPoint, manaPoint: character.manaPoint, bloodPoint: character.bloodPoint)
                                .frame(width: geo.size.width/5, height: geo.size.height/5)
                                .onTapGesture {
                                    draggedCharacter = draggedCharacter == character ? emptyCharacter : character
                                }
                                .border(.green, width: draggedCharacter == character ? 10 : 0)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .onAppear(
            perform: {
                let player = dataController.getPlayerById(with: UUID(uuidString: currentPlayer.id), context: managedObjContext)!
                
                if (player.levelStatus?.allObjects.count == 0){
                    levelStatus = dataController.addLevelStatus(context: managedObjContext, player: player)
                    let id = levelStatus.id!
                }
                else{
                    levelStatus = player.levelStatus?.allObjects.last as! LevelStatus
                }
                
            }
        )
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(LevelStatus())
    }
}
