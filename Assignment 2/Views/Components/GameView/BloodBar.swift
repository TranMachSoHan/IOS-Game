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

struct ProgressMeterView: View {
    @State var percentage: Double = 70
    
    var body: some View {
        bloodBar
    }

    
}

extension ProgressMeterView {
    var bloodBar : some View {
        GeometryReader { geo in
            ZStack (alignment: .leading){
                RoundedRectangle(cornerRadius: 40)
                    .frame(width: geo.size.width)
                    .foregroundColor(Color.gray.opacity(0.7))

                RoundedRectangle(cornerRadius: 40)
                    .frame(width: percentage/100 * geo.size.width)
                    .foregroundColor(
                        progressColor(percentage: percentage)
                    )

                Text(String(format: "%.0f%%", percentage))
                    .font(.system(size: geo.size.height > geo.size.width ? geo.size.width * 0.3: geo.size.height * 0.3))
                    .foregroundColor(.white)
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

struct ProgressMeterView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressMeterView()
    }
}
