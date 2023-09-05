import Foundation
import SwiftUI


class MedicationData: ObservableObject {
    static let shared = MedicationData() // 싱글톤 패턴을 사용하여 유일한 인스턴스 생성

    @Published var medications: [Medication] = [
        Medication(name: "아침",medication: [
            Medicine(
                id: 1,
                image: "image_덱시로펜정",
                name: "데크시로펜정",
                effect: "해열, 진통, 소염제",
                kdCode: "KD001",
                atcCode: AtcCode(code: "ATC001", score: 1),
                count: 10,
                isTaken: false,
                isOverLap: false
            ),
            Medicine(
                id: 2,
                image: "image_동광레바미피드정",
                name: "동광레바미피드정",
                effect: "소화성 궤양용제",
                kdCode: "KD001",
                atcCode: AtcCode(code: "ATC001", score: 2),
                count: 10,
                isTaken: false,
                isOverLap: false
            ),
            Medicine(
                id: 3,
                image: "image_코푸정",
                name: "코푸정",
                effect: "진해거담제",
                kdCode: "KD001",
                atcCode: AtcCode(code: "ATC001", score: 1),
                count: 10,
                isTaken: false,
                isOverLap: false
            ),
            Medicine(
                id: 4,
                image: "image_베스티온정",
                name: "베스티온정",
                effect: "해열, 진통, 소염제",
                kdCode: "KD001",
                atcCode: AtcCode(code: "ATC001", score: 1),
                count: 10,
                isTaken: false,
                isOverLap: false
            )

        ]),
        Medication(name: "점심",medication: [


        ]),
        Medication(name: "저녁", medication: [
           
        ]),
        Medication(name: "기타",medication: [
         
        ]),
    ]
    var totalMedicineCount: Int {
        return medications.reduce(0) { $0 + $1.count }
    }
    var totalTakenCount: Int {
        return medications.reduce(0) { result, medication in
            result + medication.medication.filter { $0.isTaken }.count
        }
    }

    
}
