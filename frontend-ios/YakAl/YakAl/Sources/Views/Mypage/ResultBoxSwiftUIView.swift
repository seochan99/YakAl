import SwiftUI

struct ResultBoxSwiftUIView: View {
    var title: String
    var score : Int
    
    @ObservedObject private var user = User.shared
    
    
    // 결과 변환 
    func getResultText() -> String {
        print(title)
        print(score)
           switch title {
           case "복약 순응도 테스트":
               return "\(score)/48점 입니다"
           case "우울증 선별검사 (PHQ-9)":
               if score <= 4 {
                   return "정상 입니다."
               } else if score <= 9 {
                   return "가벼운 우울증상이 있습니다."
               } else if score <= 19 {
                   return "중간정도의 우울증이 의심됩니다."
               } else {
                   return "심한 우울증이 의심됩니다."
               }
           case "음주력 테스트":
               if score <= 9 {
                   return "아직 위험 수준에는 이르지 않았습니다."
               } else if score <= 15 {
                   return "습관적 과음을 하며 주의가 필요합니다."
               } else if score <= 19 {
                   return "당신의 음주는 현재 해롭고 위험한 수준(남용)에 있습니다."
               } else {
                   return "당신의 음주는 현재 매우 위험한 수준에 있습니다."
               }
           case "흡연력 테스트":
               return "흡연 정보가 필요합니다."  // You can update this based on your real data
           case "불면증 심각도":
               if score <= 7 {
                   return "정상입니다."
               } else if score <= 14 {
                   return "약간의 불면증 경향이 있습니다."
               } else if score <= 21 {
                   return "중등도의 불면증이 있습니다."
               } else {
                   return "심한 불면증이 있습니다."
               }
//           case "현재 복용 중인 건강기능식품":
//               return "result"  // 
           default:
               return "결과 정보가 없습니다."
           }
       }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 24) {
                Text("\(user.nickName.isEmpty ? "약알" : user.nickName)님의\n\(title) 결과는")
                    .font(
                    Font.custom("SUIT", size: 16)
                    .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                    .frame(width: 340, alignment: .topLeading)
                
                Text(getResultText())
                    .font(
                    Font.custom("SUIT", size: 20)
                    .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                    .frame(width: 340, alignment: .topLeading)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20) // Side padding
            .padding(.vertical, 20) // Vertical padding
            .background(Color(red: 0.96, green: 0.96, blue: 0.98))
    }
}

struct ResultBoxSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ResultBoxSwiftUIView(title: "복약 순응도 테스트", score: 30)
    }
}
