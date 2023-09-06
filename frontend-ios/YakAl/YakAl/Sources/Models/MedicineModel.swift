import SwiftUI

//MARK: - 약물
struct Medicine:Identifiable,Hashable {
    let id: Int     // id값
    let image: String // image
    let name: String // 이름
    var effect: String // 효과
    let kdCode: String
    let atcCode: AtcCode
    var count: Int // 갯수
    var isTaken: Bool //
    let isOverLap: Bool // 중복여부
    var image2: Image?
    var drugInfo: DrugInfo?
    
    // hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//MARK: - 약물 상세
struct DrugInfo: Codable,Hashable {
    let IdentaImage: String
    let Pictogram: [Pictogram]?
    let BriefMonoContraIndication: String
    let BriefMonoSpecialPrecaution: String
    let BriefMono: String
    let BriefIndication: String
    let Interaction: String
}

//MARK: - 픽토그램
struct Pictogram: Codable,Hashable {
    let Image: String
    let Description: String
}

//MARK: - atc코드
struct AtcCode: Hashable {
    let code: String
    let score: Int
}
