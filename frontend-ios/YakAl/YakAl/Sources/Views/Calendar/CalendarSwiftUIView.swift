import SwiftUI

//MARK: - CalendarSwiftUIView : 달력 뷰
struct CalendarSwiftUIView: View {
    
    /* --------------- State --------------- */
    //currentDate 현재 일자를 불러온다.
    @State private var currentDate = Date()
    //isExpanded 확장 여부
    @State private var isExpanded = false
    // currentWeekIndex 현재 주
    @State private var currentWeekIndex: Int = 0
    // 선택한 날짜를 저장할 상태 변수 추가
    @State private var selectedDate: DayModel? = DayModel(currentDate: Date())
    
    /* --------------- dateFormatter 년 월 포멧  --------------- */
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }
    
    /* --------------- 예시 약물 --------------- */
    var sampleMedications: [Medicine] = [
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
            atcCode: AtcCode(code: "ATC001", score: 1),
            count: 10,
            isTaken: false,
            isOverLap: false
        ),
        
    ]
    
    /* --------------- 현재 주 찾기 --------------- */
    func findCurrentWeekIndex() -> Int {
        let today = Date()
        for (index, week) in sampleWeekDates.enumerated() {
            for day in week {
                if Calendar.current.isDate(day.date, inSameDayAs: today) {
                    return index // 오늘 날짜가 있는 주의 인덱스를 반환
                }
            }
        }
        return 0
    }
    
    
    /* --------------- 한줄 캘린더 데이터--------------- */
    var sampleWeekDates: [[DayModel]] {
        var allWeekDates: [[DayModel]] = []
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        
        // 시작하는 달 가져오기
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .weekOfMonth, in: .month, for: startOfMonth) else {
            return allWeekDates // // 시작 달의 데이터를 가져올 수 없는 경우 빈 배열을 반환
        }
        if let firstWeekday = calendar.dateComponents([.weekday], from: startOfMonth).weekday {
            var currentDay = startOfMonth
            
            for _ in range {
                var weekDates: [DayModel] = []
                for dayIndex in 0..<7 {
                    // 달의 첫 번째 날을 지나거나 첫 번째 주가 아닌 경우
                    if dayIndex >= firstWeekday - 1 || allWeekDates.count > 0 {
                        let dayModel = DayModel(date: currentDay, medications: sampleMedications)
                        weekDates.append(dayModel)
                        currentDay = calendar.date(byAdding: .day, value: 1, to: currentDay)!
                    }
                    // 그외
                    else {
                        weekDates.append(DayModel(date: Date(timeIntervalSince1970: 0), medications: [])) // Empty day
                    }
                }
                // 해당 주 allWeekData에 붙이기
                allWeekDates.append(weekDates)
            }
        }
        // 모든 주의 데이터
        return allWeekDates
    }
    
    /* --------------- 토,일 색상 ---------------*/
    func weekdayColor(for weekdayText: String) -> Color {
        switch weekdayText {
            case "일":
                return Color(red: 0.88, green: 0.06, blue: 0.16) // 일요일 색상
            case "토":
                return Color(red: 0.33, green: 0.53, blue: 0.99) // 토요일 색상
            default:
                return Color.black // 기본 색상
        }
    }
    
//MARK: - View Body
    var body: some View {
        ScrollView{
            
        /* --------------- 달력 뷰 --------------- */
        VStack(spacing: 16) {
            /* --------------- 달 이동 View --------------- */
            CalendarHeaderChangeMonthSwiftUIView(currentDate: $currentDate)
        
            /* --------------- 요일 불러오는 Header View --------------- */
            WeekdayHeaderSwiftUIView()
            
            /* --------------- 펼쳐졌을 경우의 View, 달 전체를 보여줌 --------------- */
            if isExpanded {
                ForEach(sampleWeekDates, id: \.self) {
                    weekDates in
                    CalendarWeekSwiftUIView(weekDates: weekDates, selectedDate: $selectedDate) // 선택한 날짜를 하위 뷰에 전달
                }
            } else {
                // 해당 주차
                CalendarWeekSwiftUIView(weekDates: sampleWeekDates[currentWeekIndex], selectedDate: $selectedDate) // 선택한 날짜를 하위 뷰에 전달

                
            }
            /* --------------- 스와이핑 아이콘 --------------- */
            VStack {
                Button(action: {
                    withAnimation {
                        self.isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .colorMultiply(Color(red: 0.56, green: 0.56, blue: 0.62, opacity: 1))
                }
            }
            .padding(.top, 20)
            
            
            
            /* --------------- 해당일 약물 TODO --------------- */
            VStack(spacing: 0){
                /* --------------- 해당일 복용 퍼센트  --------------- */
                CalendarTodoHeaderSwiftUIView(selectedDate: $selectedDate)

                // ---------------  약물 View  ---------------
                MedicationSwiftUIView()
                    .environmentObject(MedicationData())
                    .padding(.horizontal, 0) // 수평 여백을 없애는 부분
                    .padding(.vertical, 0) // 수평 여백을 없애는 부분
            }
        }
        }.onAppear {
            currentWeekIndex = findCurrentWeekIndex()
        }
    }
}



//MARK: - Date Extension
extension Date {
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var SingleDay: Int {
        return Calendar.current.component(.day, from: self)
    }
}
//MARK: -CalendarSwiftUIView_Previews
struct CalendarSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSwiftUIView()
    }
}
