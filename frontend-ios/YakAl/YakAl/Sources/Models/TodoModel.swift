struct TodoItem {
    enum MealTime: String {
        case breakfast = "아침"
        case lunch = "점심"
        case dinner = "저녁"
    }
    
    let mealTime: MealTime
    var medication: [String] // 약물 정보를 담는 배열
    
    // 이니셜라이저를 사용하여 TodoItem을 생성합니다.
    init(mealTime: MealTime, medication: [String]) {
        self.mealTime = mealTime
        self.medication = medication
    }
}
