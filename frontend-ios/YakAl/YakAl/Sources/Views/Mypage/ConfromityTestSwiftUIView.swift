import SwiftUI


struct OptionButton: View {
    var title: String
    @Binding var selected: String?
    
    var body: some View {
        Button(action: {
            self.selected = self.title
        }) {
            VStack {
                Image(selected == title ? "Check_fill" : "Check_disable")
                                                   .resizable()
                                                   .frame(width: 36, height: 36)
                Text(title)
                    .font(Font.custom("SUIT", size: 14).weight(.medium))
                    .foregroundColor(selected == title ? Color.blue : Color.gray)
            }
        }
    }
}

struct QuestionView: View {
    var question: String
    @State private var selectedOption: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(question)
                .font(Font.custom("SUIT", size: 15).weight(.medium))
                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
            HStack {
                OptionButton(title: "전혀없음", selected: $selectedOption)
                Spacer()
                OptionButton(title: "가끔", selected: $selectedOption)
                Spacer()
                OptionButton(title: "대부분", selected: $selectedOption)
                Spacer()
                OptionButton(title: "항상", selected: $selectedOption)
            }
        }.frame(maxWidth:.infinity)
            .padding(.horizontal,20)
    }
}



struct ConfromityTestSwiftUIView: View {
    // 질문 리스트
    let questions = [
        "1. 얼마나 자주 약 복용하는 것을 잊어버리십니까?",
        "2. 얼마나 자주 약을 복용하지 않겠다고 결정하십니까?",
        "3. 얼마나 자주 약 받는 것을 잊어버리십니까?",
        "4. 얼마나 자주 약이 다 떨어집니까?",
        "5. 의사에게 가기 전에 얼마나 자주 약 복용하는 것을 건너 뛰십니까?",
        "6. 몸이 나아졌다고 느낄 때 얼마나 자주 약 복용하는 것을 빠뜨리십니까?",
        "7. 몸이 아프다고 느낄 때 얼마나 자주 약 복용을 빠뜨리십니까?",
        "8. 얼마나 자주 본인의 부주의로 약 복용하는 것을 빠뜨리십니까?",
        "9. 얼마나 자주 본인의 필요에 따라 약 용량을 바꾸십니까? (원래 복용하셔야 하는 것보다 더 많게 혹은 더 적게 복용하시는 것)",
        "10. 하루 한번이상 약을 복용해야 할 때 얼마나 자주 약 복용 하는 것을 잊어버리십니까?",
        "11. 얼마나 자주 약값이 비싸서 다시 약 처방 받는 것을 미루십니까?",
        "12. 약이 떨어지기 전에 얼마나 자주 미리 계획하여 약 처방을 다시 받습니까?"
    ]
    
    
    // 뷰
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing:64){
                InfoBoxView(title: "복약 순응도 테스트", content: "약알 이용자의 복약 습관과 복약 순응도를 파악하여 의약품 복용에 도움을 드리기 위한 설문입니다.")
                
                VStack(spacing:80){
                    ForEach(questions, id: \.self) { question in
                                   QuestionView(question: question)
                               }
                }.padding(.horizontal,20)
                BlueHorizontalButton(text: "완료", action: {})
            }
            
            

        }
    }
}

struct ConfromityTestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ConfromityTestSwiftUIView()
    }
}
