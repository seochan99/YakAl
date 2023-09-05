import SwiftUI

extension Medicine: Equatable {
    static func == (lhs: Medicine, rhs: Medicine) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Medicine:Identifiable,Hashable {
    let id: Int
    let image: String
    let name: String
    let ingredients: String
    let dangerStat : Int
    let kdCode: String
    let atcCode: AtcCode
    var count: Int
    var isTaken: Bool
    var effect: String
    let isOverLap: Bool
    
    // hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct AtcCode: Hashable {
    let code: String
    let score: Int
}
