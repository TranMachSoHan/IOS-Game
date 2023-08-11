/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 11/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
*/

import SwiftUI

struct PlayerStatusView: View {
    var image: Image
    var body: some View {
        ZStack (alignment: .bottom){
            image
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.white),lineWidth: 4))
                .shadow(radius: 7)
            ProgressMeterView(percentage: 50)
                .frame(height: 30)
        }
        
        
    }
}

struct PlayerStatusView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerStatusView(image: Image("luckin317"))
    }
}
