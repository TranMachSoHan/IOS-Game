/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 20/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
 
*/

import SwiftUI

struct NameImage: View {
    var name: String
    var image: Image
    
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(0.5)
            Text(name)
        }
    }
}
