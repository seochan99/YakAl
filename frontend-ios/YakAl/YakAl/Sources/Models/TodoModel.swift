struct TodoItem {
    // 복용 시간을 나타내는 열거형
    enum MealTime: String {
        case breakfast = "아침"
        case lunch = "점심"
        case dinner = "저녁"
        case etc = "기타"
    }
    
    // 복용 시간
    let mealTime: MealTime
    
    // 약물 정보를 담는 배열
    var medication: [String]
    
    // 이니셜라이저를 사용하여 TodoItem을 생성합니다.
    init(mealTime: MealTime, medication: [String]) {
        self.mealTime = mealTime
        self.medication = medication
    }
}
