/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 09/08/2023
  Last modified: 02/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/
import SwiftUI

struct ParentDeck: View {
    var systemName : String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
        }
    }
}

struct ParentDeck_Previews: PreviewProvider {
    static var previews: some View {
        ParentDeck(systemName: "heart.fill")
    }
}