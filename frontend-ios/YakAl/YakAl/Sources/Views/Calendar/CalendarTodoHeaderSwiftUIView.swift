import SwiftUI

struct CalendarTodoHeaderSwiftUIView: View {
    
    // 선택된 날짜를 바인딩하여 받을 변수
    @Binding var selectedDate: DayModel?
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack(spacing: 16){

                    // 일자
                    HStack{
                        Text("\(String(selectedDate?.date.year ?? 2023))년 \(String(selectedDate?.date.month ?? 7))월 \(String(selectedDate?.date.SingleDay ?? 20))일")
                          .font(
                            Font.custom("SUIT", size: 15)
                              .weight(.semibold)
                          )
                          .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 복용 갯수
                    HStack(spacing: 8){
                        Text("14개 복용 ")
                          .font(
                            Font.custom("SUIT", size: 20)
                              .weight(.bold)
                          )
                          .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                        
                        // 총 갯수
                        Text("(15개)")
                          .font(
                            Font.custom("SUIT", size: 15)
                              .weight(.semibold)
                          )
                          .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                // 복용 퍼센트
                VStack{
                    CircularProgressBarWithText(progress: 0.70)
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,20)
                .padding(.top,40)
                .padding(.bottom,20)
                .background(Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1))
            
        }
    }
}

struct CalendarTodoHeaderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTodoHeaderSwiftUIView(selectedDate: .constant(DayModel(currentDate: Date())))
    }
}
