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
    https://github.com/TomHuynhSG/SSET-Contact-List-iOS/blob/main/ContactList/Model/ModelData.swift
*/

import Foundation
import SwiftUI


struct Badge : Codable, Hashable {
    var name: String = ""
    var score: Int32 = 0
    var imageName: String = ""
    var image: Image {
        Image(imageName)
    }
}

var badges = decodeJsonFromJsonFile(jsonFileName: "badges.json")

func findBadgeByName(name: String) -> Badge{
    return badges.first(where: {$0.name == name}) ?? badges[0]
}
