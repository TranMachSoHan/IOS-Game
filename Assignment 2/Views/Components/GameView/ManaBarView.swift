/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 13/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
    https://seons-dev.tistory.com/entry/Stack-%EC%A1%B0%ED%95%A9
    https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
*/

import SwiftUI

struct ManaBarView: View {
    @Binding var manaPoint: Int
    
    var body: some View {
        GeometryReader{g in
            ZStack {
                Color.black.opacity(0.5)
                HStack{
                    ForEach((1...6), id: \.self) {index in
                        if index > manaPoint{
                            Circle()
                                .fill(Color.black)
                        }
                        else{
                            Circle()
                                .fill(Color.green)
                        }
                        
                    }
                }
            }
        }
    }
}

//struct ManaBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ManaBarView(manaPoint: 3)
//    }
//}
