import SwiftUI

//MARK: - Calendar Week View : 매 주차 뷰
struct CalendarWeekView: View {
    var weekDates: [DayModel]
    @Binding var selectedDate: DayModel? // 선택한 날짜를 바인딩

    var body: some View {
        HStack(spacing:20) {
                   ForEach(weekDates, id: \.self) { date in
                       let isSelectedDate = date.dayText == selectedDate?.dayText && date.date.month == selectedDate?.date.month

                       if isFirstWeek() && date.date.day == "1" {
                           if isLastOne(in: weekDates, current: date) {
                               CircularProgressBar(progress: 0.9, dateText: date.dayText, today: isSameDate(date.date, Date()), weekDates: date.weekdayText, isSelected: isSelectedDate)
                                   .padding(.top, 4)
                                   .onTapGesture {
                                       selectedDate = date
                                   }
                           } else {
                               CircularProgressBar(progress: 0, dateText: "  ", today: false, weekDates: date.weekdayText, isSelected: false)
                                   .padding(.top, 4)
                           }
                       } else if isLastWeek() && (Int(date.date.day)! <= 7 || date.date.day == "1") {
                           CircularProgressBar(progress: 0, dateText: "  ", today: false, weekDates: date.weekdayText, isSelected: false)
                               .padding(.top, 4)
                               .onTapGesture {
                                   selectedDate = date
                               }
                       } else {
                           CircularProgressBar(progress: 0.2, dateText: date.dayText, today: isSameDate(date.date, Date()), weekDates: date.weekdayText, isSelected: isSelectedDate)
                               .padding(.top, 4)
                               .onTapGesture {
                                   selectedDate = date
                               }
                       }
                   }
               }.padding(.horizontal,20)
        
      }
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func isFirstWeek() -> Bool {
        return weekDates.contains(where: { $0.date.day == "1" })
    }
    
    
    func isLastOne(in dates: [DayModel], current: DayModel) -> Bool {
        if let lastOne = dates.last(where: { $0.date.day == "1" }) {
            return lastOne.id == current.id
        }
        return false
    }
    
    func isLastWeek() -> Bool {
        return weekDates.contains(where: { $0.date.day == "28" || $0.date.day == "29" || $0.date.day == "30" || $0.date.day == "31" })
    }
    
    
    
    
    func weekdayColor(for weekdayText: String) -> Color {
        switch weekdayText {
        case "일":
            return Color(red: 0.88, green: 0.06, blue: 0.16)
        case "토":
            return Color(red: 0.33, green: 0.53, blue: 0.99)
        default:
            return Color.black
        }
    }
}
//MARK: - CalendarSwiftUIView : 달력 뷰
struct CalendarSwiftUIView: View {
    // --------------- 상태 ---------------
    @State private var currentDate = Date()
    @State private var isExpanded = false
    
    @State private var currentWeekIndex: Int = 0
    
    // 선택한 날짜를 저장할 상태 변수 추가
    @State private var selectedDate: DayModel? = DayModel(currentDate: Date())


    /* --------------- 요일 스트링 --------------- */
    

    // 년 월 표현
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }
    
    // 예시 약물
    var sampleMedications: [Medicine] = [
        Medicine(id: 1, image: "image_덱시로펜정", name: "약물A", ingredients: "성분 A", dangerStat: 0, isTaken: false),
        Medicine(id: 2, image: "image_덱시로펜정", name: "약물B", ingredients: "성분 B", dangerStat: 1, isTaken: false)
        
    ]
    
    func findCurrentWeekIndex() -> Int {
        let today = Date()
        for (index, week) in sampleWeekDates.enumerated() {
            for day in week {
                if Calendar.current.isDate(day.date, inSameDayAs: today) {
                    return index
                }
            }
        }
        return 0 // Default to the first week if not found
    }
    
    /* --------------- 한줄 캘린더 데이터--------------- */
    var sampleWeekDates: [[DayModel]] {
        var allWeekDates: [[DayModel]] = []
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .weekOfMonth, in: .month, for: startOfMonth) else {
            return allWeekDates
        }
        
        if let firstWeekday = calendar.dateComponents([.weekday], from: startOfMonth).weekday {
            var currentDay = startOfMonth
            
            for _ in range {
                var weekDates: [DayModel] = []
                
                for dayIndex in 0..<7 {
                    if dayIndex >= firstWeekday - 1 || allWeekDates.count > 0 { // If the index has passed the first day of the month or it's not the first week anymore
                        let dayModel = DayModel(date: currentDay, medications: sampleMedications)
                        weekDates.append(dayModel)
                        currentDay = calendar.date(byAdding: .day, value: 1, to: currentDay)!
                    } else {
                        weekDates.append(DayModel(date: Date(timeIntervalSince1970: 0), medications: [])) // Empty day
                    }
                }
                allWeekDates.append(weekDates)
            }
        }
        
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
    
    var body: some View {
        ScrollView{
            
        // --------------- 달력 뷰 ---------------
        VStack(spacing: 16) {
            HStack(spacing:20) {
                Spacer()
                // --------------- 이전버튼  ---------------
                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image("previous-month")
                }
                // --------------- 년/월  ---------------
                Text(dateFormatter.string(from: currentDate))
                    .font(
                        Font.custom("SUIT", size: 15)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                // --------------- 다음버튼  ---------------
                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image("next-month")
                }
                Spacer()
            }.padding(.top, 20)
                .padding(.bottom, 15)
            
            // --------------- 요일  ---------------
            WeekdayHeaderSwiftUIView()
            

            
            // --------------- 펼쳐졌을 경우의 뷰  ---------------
            if isExpanded {
                // 매일자 삽입
                ForEach(sampleWeekDates, id: \.self) {
                    weekDates in
                    CalendarWeekView(weekDates: weekDates, selectedDate: $selectedDate) // 선택한 날짜를 하위 뷰에 전달
                }
            } else {
                // 해당 주차
                CalendarWeekView(weekDates: sampleWeekDates[currentWeekIndex], selectedDate: $selectedDate) // 선택한 날짜를 하위 뷰에 전달

                
            }
            // --------------- 스와이핑 아이콘 ---------------
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
            
            // --------------- 복용 퍼센트  ---------------
            VStack(spacing: 0){
                HStack{
                    VStack(spacing: 16){

                        // --------------- 일자  ---------------
                        HStack{
                            Text("\(String(selectedDate?.date.year ?? 2023))년 \(String(selectedDate?.date.month ?? 7))월 \(String(selectedDate?.date.SingleDay ?? 20))일")
                              .font(
                                Font.custom("SUIT", size: 15)
                                  .weight(.semibold)
                              )
                              .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        // --------------- 복용 갯수  ---------------
                        HStack(spacing: 8){
                            Text("14개 복용 ")
                              .font(
                                Font.custom("SUIT", size: 20)
                                  .weight(.bold)
                              )
                              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                            
                            // --------------- 총 갯수  ---------------
                            Text("(15개)")
                              .font(
                                Font.custom("SUIT", size: 15)
                                  .weight(.semibold)
                              )
                              .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    // --------------- 복용 퍼센트  ---------------
                    VStack{
                        CircularProgressBarWithText(progress: 0.70)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading) // 왼쪽에 붙이는 부분
                    .padding(.horizontal,20)
                    .padding(.top,40)
                    .padding(.bottom,20)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1))
                
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


//MARK: - 원 프로그레스바 : 달력 뷰
struct CircularProgressBarWithText: View {
    var progress: Double
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .opacity(0.3)
                .foregroundColor(Color(red: 0.76, green: 0.82, blue: 1))
            Circle()
                .trim(from: 0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(red: 0.33, green: 0.53, blue: 0.99))
                .rotationEffect(Angle(degrees: -90))
            VStack {
                Text("\(Int(progress * 100))%")
                    .font(Font.custom("SUIT", size: 16).weight(.semibold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(progress == 0 ? Color(red: 0.76, green: 0.82, blue: 1) : Color(red: 0.33, green: 0.53, blue: 0.99))
            }
        }
        .frame(width: 60, height: 60)
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
