/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 18/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import SwiftUI

struct SwitchUserView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var currentPlayer: CurrentPlayer
    @Environment(\.managedObjectContext) var managedObjContext
    @EnvironmentObject var dataController: DataController
    @Environment(\.dismiss) var dismiss
    
    @State var showPopUpAuth: Bool = false
    @State var showPopUpBadge: Bool = false
    @State var popUpTypeString: String = "Sign In"
    @State var name: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var clickedPlayerId : String = ""
    
    var body: some View {
        ZStack (alignment: .top){
            //background
            Color.blue
                .opacity(0.2)
                .ignoresSafeArea()
            
            VStack() {
                //Back to menu button
                HStack{
                    if (currentPlayer.id != ""){
                        Button(action: {
                            withAnimation {
                                viewRouter.currentPage = .menuPage
                            }}) {
                                Text("< Go Back")
                                    .underline()
                            }
                    }
                    
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.popUpTypeString = "Sign Up"
                            self.name = ""
                            self.password = ""
                            self.showPopUpAuth = true
                        }}) {
                            Text("Sign Up")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                }.padding(.horizontal, 20)
                
                
                //Show list of players in leaderboard
                PlayerList(name: $name, password: $password, showPopUpAuth: $showPopUpAuth, popUpTypeString: $popUpTypeString, clickedPlayerId: $clickedPlayerId)
            }
        }
        .sheet(isPresented: $showPopUpAuth){
            SignInUpView(popUpTypeString: $popUpTypeString, name: $name, pass: $password, showPopUpAuth: $showPopUpAuth, error: error, onClose: self.onCheckingAuthen)
        }
        .sheet(isPresented: $showPopUpBadge) {
            EarnNewBadgeView(badge: findBadgeByName(name: "New Member"), showPopUpBadge: $showPopUpBadge)
        }
    }
    
    func onCheckingAuthen(){
        if (self.name.isEmpty || self.password.isEmpty){
            error = "Name or password cannot be empty"
        }
        
        if (self.popUpTypeString == "Sign In"){
            // TODO: compare password for authentication
            let player: Player = dataController.getPlayerById(with: UUID(uuidString: clickedPlayerId), context: managedObjContext)!
            currentPlayer.setPlayer(player: player)
            viewRouter.currentPage = .menuPage
        }
        else {
            let player: Player = dataController.addPlayer(name: self.name, pass: self.password, context: managedObjContext)
            currentPlayer.setPlayer(player: player)
            dataController.updateScore(badge: findBadgeByName(name: "New Member"), id: player.id!, context: managedObjContext)
            showPopUpAuth = false
            showPopUpBadge = true
        }
    }
}

struct SwitchUserView_Previews: PreviewProvider {
    static var previews: some View {
        SwitchUserView()
            .environmentObject(ViewRouter())
            .environmentObject(CurrentPlayer())
    }
}
