///*
//  RMIT University Vietnam
//  Course: COSC2659 iOS Development
//  Semester: 2022B
//  Assessment: Assignment 2
//  Author: Tran Mach So Han
//  ID: s3750789
//  Created  date: 09/08/2023
//  Last modified: 02/09/2023
//  Acknowledgement:
// 
//*/
//
//
//import SwiftUI
//
//struct LoadingGameView: View {
//    @EnvironmentObject var currentPlayer: CurrentPlayer
//    @Environment(\.managedObjectContext) var managedObjContext
//    @EnvironmentObject var dataController: DataController
//    @State var levelStatus  : LevelStatus = LevelStatus()
//    @State var mainBoard: MainBoard = MainBoard()
//    @State var isLoading: Bool = true
//    
//    // What this View do :
//    // Let user choose level
//    // Load In progress Level Status , if no then direct to
//    // and Mainboard
//    var body: some View {
//        ZStack {
//            
//        }
//        .onAppear(
//            perform: {
//                let player = dataController.getPlayerById(with: UUID(uuidString: currentPlayer.id), context: managedObjContext)!
//                
//                if (player.levelStatus?.allObjects.count == 0){
//                    levelStatus = dataController.addLevelStatus(context: managedObjContext, player: player)
//                    mainBoard = levelStatus.mainBoard as MainBoard
//                }
//                else{
//                    levelStatus = player.levelStatus?.allObjects.last as! LevelStatus
//                    dataController.addMainBoardToLevelStatus(context: managedObjContext, levelStatus: levelStatus)
//                    mainBoard = levelStatus.mainBoard!
//                }
//                isLoading = false
//                
//            }
//        )
//    }
//    
//}
//
//struct LoadingGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingGameView()
//            .environment(\.managedObjectContext, DataController().container.viewContext)
//            .environmentObject(DataController())
//            .environmentObject(CurrentPlayer())
//    }
//}
