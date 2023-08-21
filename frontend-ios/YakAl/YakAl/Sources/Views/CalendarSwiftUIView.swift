import SwiftUI

//MARK: - Day Model
struct DayModel: Identifiable,Hashable {
    let id = UUID()
    let date: Date
    let medications: [Medicine] // List of medications for the day
    
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

    var fullWeekdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}

//MARK: - Calendar Week View : 매 주차 뷰
struct CalendarWeekView: View {
    // 모델 생성
    var weekDates: [DayModel]
    
    // 뷰
    var body: some View {
        HStack(spacing: 30) {
            ForEach(weekDates, id: \.self) { date in
                VStack {
                    Text("\(date.weekdayText)")
                        .font(.headline)
                        .foregroundColor(weekdayColor(for: date.weekdayText))
                    Text("\(date.dayText)")
                        .font(.headline)
                        .foregroundColor(weekdayColor(for: date.weekdayText))
                }
            }
        }
    }
    
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



struct CalendarSwiftUIView: View {
    @State private var currentDate = Date()
    @State private var isExpanded = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }
    // Sample data for medications
    var sampleMedications: [Medicine] = [
        Medicine(id: 1, image: "image_덱시로펜정", name: "약물A", ingredients: "성분 A", dangerStat: 0, isTaken: false),
        Medicine(id: 2, image: "image_덱시로펜정", name: "약물B", ingredients: "성분 B", dangerStat: 1, isTaken: false)
    ]
    // Generate sample DayModels for a week
      var sampleWeekDates: [DayModel] {
          var weekDates: [DayModel] = []
          let calendar = Calendar.current
          let startDate = calendar.startOfDay(for: currentDate)
          for day in 0..<7 {
              if let date = calendar.date(byAdding: .day, value: day, to: startDate) {
                  let dayModel = DayModel(date: date, medications: sampleMedications)
                  weekDates.append(dayModel)
              }
          }
          return weekDates
      }

    var body: some View {
        ScrollView{
            
        
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image(systemName: "arrow.left")
                }
                
                Text(dateFormatter.string(from: currentDate))
                    .font(
                        Font.custom("SUIT", size: 15)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))

                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image(systemName: "arrow.right")
                }
                Spacer()
            }
            
            // 펼쳐졌을 경우의 뷰
            if isExpanded {
                         ForEach(0..<5, id: \.self) { _ in
                             // Display sample week dates using CalendarWeekView
                             CalendarWeekView(weekDates: sampleWeekDates)
                         }
                     } else {
             // 접혔을떄
                         CalendarWeekView(weekDates: sampleWeekDates)
                     }
            
            // 달력 펼치기
            Button(action: {
                self.isExpanded.toggle()
            }) {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            
            // 약물 뷰
            ForEach(0..<5) { _ in
                let dummyDayModel = DayModel(date: Date(), medications: [
                    Medicine(id: 1, image: "image_덱시로펜정", name: "약물A", ingredients: "성분 A", dangerStat: 0, isTaken: false),
                    Medicine(id: 2, image: "image_덱시로펜정", name: "약물B", ingredients: "성분 B", dangerStat: 1, isTaken: false)
                ])
                
                VStack {
                    Text("\(dummyDayModel.fullWeekdayText), \(dummyDayModel.weekdayText)")
                        .font(.headline)
                    Text(dummyDayModel.dayText)
                        .font(.headline)
                }
                
                ForEach(dummyDayModel.medications, id: \.self) { medication in
                    Text(medication.name)
                }
            }
        }
        .padding()
    }
    }
}


extension Date {
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
}
struct CalendarSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSwiftUIView()
    }
}
