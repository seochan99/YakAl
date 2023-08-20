import SwiftUI

struct Medicine:Identifiable {
    let id: Int
    let image: String
    let name: String
    let ingredients: String
    let dangerStat : Int
    var isTaken: Bool //
}
