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
    var index: Int
       var question: String
    @Binding var selectedOption: String?


    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("\(index + 1). \(question)") // 인덱스를 붙여서 표시
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
        "얼마나 자주 약 복용하는 것을 잊어버리십니까?",
        "얼마나 자주 약을 복용하지 않겠다고 결정하십니까?",
        "얼마나 자주 약 받는 것을 잊어버리십니까?",
        "얼마나 자주 약이 다 떨어집니까?",
        "의사에게 가기 전에 얼마나 자주 약 복용하는 것을 건너 뛰십니까?",
        "몸이 나아졌다고 느낄 때 얼마나 자주 약 복용하는 것을 빠뜨리십니까?",
        "몸이 아프다고 느낄 때 얼마나 자주 약 복용을 빠뜨리십니까?",
        "얼마나 자주 본인의 부주의로 약 복용하는 것을 빠뜨리십니까?",
        "얼마나 자주 본인의 필요에 따라 약 용량을 바꾸십니까? (원래 복용하셔야 하는 것보다 더 많게 혹은 더 적게 복용하시는 것)",
        "하루 한번이상 약을 복용해야 할 때 얼마나 자주 약 복용 하는 것을 잊어버리십니까?",
        "얼마나 자주 약값이 비싸서 다시 약 처방 받는 것을 미루십니까?",
        "약이 떨어지기 전에 얼마나 자주 미리 계획하여 약 처방을 다시 받습니까?"
    ]
    // 각 질문에 대한 선택을 저장하는 배열
    @State private var selectedOptions = Array(repeating: nil as String?, count: 12)
    @State private var displayScore: Bool = false
    
    // 모든 문항이 선택되었는지 확인
    var allQuestionsAnswered: Bool {
        return !selectedOptions.contains { $0 == nil || $0!.isEmpty }
    }
    
    // 점수 계산
      var totalScore: Int {
          selectedOptions.reduce(0) { score, option in
              switch option {
              case "전혀없음":
                  return score + 1
              case "가끔":
                  return score + 2
              case "대부분":
                  return score + 3
              case "항상":
                  return score + 4
              default:
                  return score
              }
          }
      }
    
    // 뷰
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing:64){
                InfoBoxView(title: "복약 순응도 테스트", content: "약알 이용자의 복약 습관과 복약 순응도를 파악하여 의약품 복용에 도움을 드리기 위한 설문입니다.")
                
                VStack(spacing: 80) {
                    ForEach(questions.indices, id: \.self) { index in
                        QuestionView(index: index, question: questions[index], selectedOption: $selectedOptions[index])
                    }
                }.padding(.horizontal,20)

                BlueHorizontalButton(text: "완료", action: {
                    print(totalScore)
                },
                isEnabled: allQuestionsAnswered
                                     )
                

            }
            
            

        }
    }
}

struct TestDoneSwiftUIView: View {
    var score: Int
    
    var body: some View {
        Text("Your Score: \(score)")
    }
}

struct ConfromityTestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ConfromityTestSwiftUIView()
    }
}
