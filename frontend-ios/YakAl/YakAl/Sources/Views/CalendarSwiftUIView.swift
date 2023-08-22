import SwiftUI

//MARK: - Day Model
struct DayModel: Identifiable,Hashable {
    let id = UUID()
    let date: Date
    let medications: [Medicine] // List of medications for the day
    
    // 일자로 변경
    var dayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    // 한국어 요일 변환
    var weekdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        return formatter.string(from: date)
    }
    // 하류 약 섭취률
    var medicineIntakeRate: Double {
        let takenCount = medications.filter { $0.isTaken }.count
        return Double(takenCount) / Double(medications.count)
    }
}

//MARK: - Calendar Week View : 매 주차 뷰
struct CalendarWeekView: View {
    var weekDates: [DayModel]
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(weekDates, id: \.self) { date in
                VStack {
                    if isSameDate(date.date, Date()) {
                        // date.medicineIntakeRate
                        CircularProgressBar(progress: 0.6, dateText: date.dayText, today:true, weekDates:date.weekdayText)
                            .padding(.top, 4)
                    } else {
                        CircularProgressBar(progress: 0.2
                                            , dateText: date.dayText, today:false, weekDates:date.weekdayText)
                            .padding(.top, 4)

                    }
                        
                }
            }
        }.padding(.horizontal,20)
        
        
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
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
    @State private var currentWeekIndex = 3 //
    
    // --------------- 요일 스트링 ---------------
    let weekStringdate : [String] = ["일","월","화","수","목","금","토"]

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
    
    // --------------- 한줄 캘린더 데이터---------------

    var sampleWeekDates: [[DayModel]] {
        var allWeekDates: [[DayModel]] = []
        
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        // 2023-07-31 15:00:00 +0000
    
        
        guard let startOfMonth = calendar.date(from: components),
              let range = calendar.range(of: .weekOfMonth, in: .month, for: startOfMonth) else {
            return allWeekDates
        }
        
        print("startOfMonth : \(startOfMonth)")
        
        for week in range {
            print(week)
            var weekDates: [DayModel] = []
            let startOfWeek = calendar.date(bySetting: .weekOfMonth, value: week, of: startOfMonth)!
            print(startOfWeek)
            for day in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                    let dayModel = DayModel(date: date, medications: sampleMedications)
                    weekDates.append(dayModel)
                }
            }
            allWeekDates.append(weekDates)
        }
        return allWeekDates
    }

    
    
    // --------------- 토,일 색상 ---------------
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
            HStack(spacing:20) {
                ForEach(weekStringdate, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(weekdayColor(for: symbol))
                }
            }.padding(.horizontal,20)
            

            
            // --------------- 펼쳐졌을 경우의 뷰  ---------------
            if isExpanded {
                // 매일자 삽입
                ForEach(sampleWeekDates, id: \.self) {
                    weekDates in
                    CalendarWeekView(weekDates: weekDates)
                }
            } else {
                // 해당 주차
                CalendarWeekView(weekDates: sampleWeekDates[currentWeekIndex])
                
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
                            Text("2023년 7월 20일")
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


//MARK: - 원 프로그레스바 : 달력 일자 위에
struct CircularProgressBar: View {
    var progress: Double
    var dateText: String // Add dateText parameter
    var today : Bool
    var weekDates : String
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
            VStack{
                if(today == true)
                {
                    Circle()
                        .fill(Color(red: 0.33, green: 0.53, blue: 0.99))
                        .frame(width: 24, height: 24)
                        .overlay(
                            Text("\(dateText)")
                                .font(Font.custom("SUIT", size: 12).weight(.medium))
                                .foregroundColor(Color.white)
                        )
                }else{
                    Text(dateText)
                        .foregroundColor(weekdayColor(for: weekDates))
                        .font(Font.custom("SUIT", size: 12).weight(.medium))
                        .foregroundColor(Color.black)
                }
                
            }
            
        }
        .frame(width: 32, height: 32)
    }
    
    // --------------- 토,일 색상 ---------------
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
}

//MARK: - Date Extension
extension Date {
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
}
//MARK: -CalendarSwiftUIView_Previews
struct CalendarSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSwiftUIView()
    }
}
