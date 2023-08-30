
import SwiftUI

struct DifficultMode {
  var modeName: String
  var description: String
}

var badges = decodeJsonFromJsonFile(jsonFileName: "difficultMode.json")
