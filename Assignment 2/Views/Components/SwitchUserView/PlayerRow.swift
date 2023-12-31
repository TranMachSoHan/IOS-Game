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

struct PlayerRow: View {
    var player: Player
    
    var body: some View {
        NameImage(name: player.name!, image: Image(player.imageName!))
    }
}
