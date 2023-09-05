/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Tran Mach So Han
  ID: s3750789
  Created  date: 07/08/2023
  Last modified: 02/09/2023
  Acknowledgement:
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
*/

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .menuPage
}
