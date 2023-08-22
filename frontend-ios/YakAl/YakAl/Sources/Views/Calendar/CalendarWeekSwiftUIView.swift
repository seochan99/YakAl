//
//  CalendarWeekSwiftUIView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/22.
//

import SwiftUI

//MARK: - Calendar Week View : 매 주차 뷰
struct CalendarWeekSwiftUIView: View {
    
    // weekDates 매주 DayModel로 불러옴
    var weekDates: [DayModel]
    
    // 선택한 날짜를 바인딩해서 받음
    @Binding var selectedDate: DayModel?

    var body: some View {
        HStack(spacing:20) {
                   ForEach(weekDates, id: \.self) { date in
                       let isSelectedDate = date.dayText == selectedDate?.dayText && date.date.month == selectedDate?.date.month
                       if isLastWeek() && (Int(date.date.day)! <= 7 || date.date.day == "1") {
                           CircularProgressBar(progress: 0, dateText: "  ", today: false, weekDates: date.weekdayText, isSelected: false)
                               .padding(.top, 4)
                               .onTapGesture {
                                   selectedDate = date
                               }
                       }
                        else if isFirstWeek() && date.date.day == "1" {
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
                       }
                        else {
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

struct CalendarWeekSwiftUIView_Previews: PreviewProvider {
    @State static var selectedDate: DayModel? = DayModel(currentDate: Date())
    
    static var previews: some View {
        CalendarWeekSwiftUIView(weekDates: sampleWeek, selectedDate: $selectedDate)
    }

    static var sampleWeek: [DayModel] {
        let startDate = Date()
        let calendar = Calendar.current
        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: offset, to: startDate)!
            return DayModel(date: date, medications: [])
        }
    }
}
