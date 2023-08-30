//
//  JsonProcessor.swift
//  Assignment 2
//
//  Created by macOS on 19/08/2023.
//

import Foundation

// How to decode a json file into a struct
func decodeJsonFromJsonFile(jsonFileName: String) -> [Badge] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Badge].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [Badge]
}
