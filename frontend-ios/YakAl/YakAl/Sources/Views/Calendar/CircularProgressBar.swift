import SwiftUI

//MARK: - 원 프로그레스바 : 달력 일자 위에
struct CircularProgressBar: View {
    var progress: Double
    var dateText: String // Add dateText parameter
    var today : Bool
    var weekDates : String
    var isSelected: Bool = false // 선택된 날짜인지 나타내는 변수 추가
    


    var body: some View {
        ZStack {
               if dateText != "  " {
                   Circle()
                       .stroke(lineWidth: 3)
                       .opacity(0.3)
                       .foregroundColor(Color(red: 0.76, green: 0.82, blue: 1))
                   
                   Circle()
                       .trim(from: 0, to: CGFloat(min(self.progress, 1.0)))
                       .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                       .foregroundColor(Color(red: 0.33, green: 0.53, blue: 0.99))
                       .rotationEffect(Angle(degrees: -90))
                   
                   if isSelected {
                       Circle()
                           .fill(Color(red: 0.33, green: 0.53, blue: 0.99))
                           .frame(width: 24, height: 24)
                           .overlay(
                               Text("\(dateText)")
                                   .font(Font.custom("SUIT", size: 12).weight(.medium))
                                   .foregroundColor(Color.white)
                           )
                   } else {
                       Text(dateText)
                           .foregroundColor(weekdayColor(for: weekDates))
                           .font(Font.custom("SUIT", size: 12).weight(.medium))
                       
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
