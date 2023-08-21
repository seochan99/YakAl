import Foundation
import SwiftUI


class MedicationData: ObservableObject {
    @Published var medications: [Medication] = [
        Medication(name: "아침",medication: [
            Medicine(id: 1, image: "image_덱시로펜정", name: "덱시로펜정", ingredients: "해열, 진통, 소염제", dangerStat: 0, isTaken: false),
            Medicine(id: 2, image: "image_덱시로펜정", name: "동화디트로판정", ingredients: "소화성 궤양용제", dangerStat: 1, isTaken: false),
            Medicine(id: 3, image: "image_덱시로펜정", name: "동광레바미피드정", ingredients: "소화성 궤양용제", dangerStat: 1, isTaken: false)
        ]),
        Medication(name: "점심",medication: [
            Medicine(id: 3, image: "image_덱시로펜정", name: "약물C", ingredients: "성분 C", dangerStat: 2, isTaken: false),
            Medicine(id: 4, image: "image_덱시로펜정", name: "약물D", ingredients: "성분 D", dangerStat: 1, isTaken: false)
        ]),
        Medication(name: "저녁", medication: [
            Medicine(id: 5, image: "image_덱시로펜정", name: "약물E", ingredients: "성분 E", dangerStat: 2, isTaken: false),
            Medicine(id: 6, image: "image_덱시로펜정", name: "약물F", ingredients: "성분 F", dangerStat: 1, isTaken: false)
        ]),
        Medication(name: "기타",medication: [
            Medicine(id: 7, image: "image_덱시로펜정", name: "약물G", ingredients: "성분 G", dangerStat: 0, isTaken: false),
            Medicine(id: 8, image: "image_덱시로펜정", name: "약물H", ingredients: "성분 H", dangerStat: 1, isTaken: false),
            Medicine(id: 9, image: "image_덱시로펜정", name: "약물J", ingredients: "성분 J", dangerStat: 2, isTaken: false)
        ]),
    ]
    var totalMedicineCount: Int {
        return medications.reduce(0) { $0 + $1.count }
    }
    @Published var totalCompletedCount: Int = 0

}
