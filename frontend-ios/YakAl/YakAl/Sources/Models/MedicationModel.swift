import Foundation


struct Medication: Identifiable {
    let id = UUID()
    let name: String
    var completedCount: Int = 0 // 복용한 약
    // 모두 먹었는지
    var isAllCompleted: Bool {
        return completedCount == count
    }
    var medication: [Medicine]
    var count: Int {
        return medication.count
    }
    var takenPercentage: Double {
        let takenCount = medication.filter { $0.isTaken }.count
        return Double(takenCount) / Double(count)
    }
}

