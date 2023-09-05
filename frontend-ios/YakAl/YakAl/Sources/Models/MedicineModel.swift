import SwiftUI

extension Medicine: Equatable {
    static func == (lhs: Medicine, rhs: Medicine) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Medicine:Identifiable,Hashable {
    let id: Int     // id값
    let image: String // image
    let name: String // 이름
    var effect: String // 효과
    let kdCode: String
    let atcCode: AtcCode
    var count: Int // 갯수
    var isTaken: Bool // 복용여부
    let isOverLap: Bool // 중복여부
    
    // hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


struct AtcCode: Hashable {
    let code: String
    let score: Int
}
