import Foundation


struct Medication: Identifiable {
    let id = UUID()
    let name: String
    var completedCount: Int = 0 // 복용한 약
    // 모두 먹었는지
    var isAllCompleted: Bool {
        return completedCount == count
    }
    let medication: [Medicine]
    var count: Int {
        return medication.count
    }
}

