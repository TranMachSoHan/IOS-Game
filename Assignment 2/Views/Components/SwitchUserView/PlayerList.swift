/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 19/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://www.pinterest.com/imabamfyo/game-ui-splash-welcome-screens/
    https://stackoverflow.com/questions/56443535/swiftui-text-alignment
*/

import SwiftUI

struct PlayerList: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Environment(\.managedObjectContext) var managedObjContext
//    @ObservedObject var currentPlayer: Player
    @Environment(\.dismiss) var dismiss
    @State var showPopUp: Bool = false
    @State var popUpTypeString: String = "Sign In"
    @State var name: String = ""
    @State var password: String = ""
    @State var error: String = ""
    
    let columns = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
    ]
    
    //Fetch players
    @FetchRequest(sortDescriptors: []) var player: FetchedResults<Player>

    var body: some View {
        ZStack (alignment: .top){
            //background
            Color.blue
                .opacity(0.2)
                .ignoresSafeArea()
            
            VStack() {
                //Back to menu button
                HStack{
                    Button(action: {
                        withAnimation {
                            viewRouter.currentPage = .menuPage
                        }}) {
                            Text("< Go Back")
                                .underline()
                        }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.name = ""
                            self.password = ""
                            self.showPopUp = true
                            self.popUpTypeString = "Sign Up"
                        }}) {
                            Text("Sign Up")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                }.padding(.horizontal, 20)
                
                
                //Show list of players in leaderboard
                VStack {
                    Text("Choose Player")
                        .font(.title)
                    
                    if (player.isEmpty){
                        Image("no-data")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 100)
                        Text("No Player in database")
                            .font(.system(size: 30))
                        
                    }
                    else{
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(player) {player in
                                PlayerRow(player: player)
                                    .onTapGesture {
                                        self.name = player.name!
                                        self.password = ""
                                        self.showPopUp = true
                                        self.popUpTypeString = "Sign In"
                                    }
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showPopUp){
            SignInUpView(popUpTypeString: popUpTypeString, name: $name, pass: $password, error: error, onClose: self.onCheckingAuthen)
        }
    }
    
    func onCheckingAuthen(){
        if (self.name.isEmpty || self.password.isEmpty){
            error = "Name or password cannot be empty"
        }
        
        
        if (self.popUpTypeString == "Sign In"){
            // TODO: compare password for authentication
            viewRouter.currentPage = .menuPage
        }
        else {
            DataController().addPlayer(name: self.name, pass: self.password, context: managedObjContext)
            dismiss()
            viewRouter.currentPage = .menuPage
        }
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
        PlayerList().environmentObject(ViewRouter())
    }
}
