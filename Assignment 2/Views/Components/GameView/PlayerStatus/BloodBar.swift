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

struct  BloodBarView: View {
    @Binding var percentage: Int
    @State var originBloodPoint: Int
    
    var body: some View {
        bloodBar
    }

    
}

extension BloodBarView {
    var bloodBar : some View {
        GeometryReader { geo in
            ZStack (alignment: .leading){
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: geo.size.width)
                    .foregroundColor(Color.gray.opacity(0.7))

                RoundedRectangle(cornerRadius: 40)
                    .frame(width: Double(percentage)/Double(originBloodPoint) * 100 * geo.size.width)
                    .foregroundColor(
                        progressColor(percentage: Double(percentage)/Double(originBloodPoint) * 100)
                    )

                Text("\(percentage)")
                    .font(.system(size: geo.size.height > geo.size.width ? geo.size.width * 0.8: geo.size.height * 0.8))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
    }
    func progressColor(percentage: Double) -> Color {
        if percentage <= 30 {
            return Color.red
        } else if percentage <= 60 {
            return Color.orange
        } else {
            return Color.green
        }
    }
}
//
//struct ProgressMeterView_Previews: PreviewProvider {
//    static var previews: some View {
//        BloodBarView()
//    }
//}
