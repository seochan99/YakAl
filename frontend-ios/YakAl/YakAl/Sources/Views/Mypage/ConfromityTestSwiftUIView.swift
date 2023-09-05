import SwiftUI

struct ConfromityTestSwiftUIView: View {
    @ObservedObject private var user = User.shared
    
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
    
    let options = ["전혀없음", "가끔", "대부분", "항상"]
    
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
              case options[0]:
                  return score + 1
              case options[1]:
                  return score + 2
              case options[2]:
                  return score + 3
              case options[3]:
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
                            RowQuestionView(index: index, question: questions[index], options: self.options, selectedOption: $selectedOptions[index])
                        }
                    }.padding(.horizontal,20)
                    
                    NavigationLink(destination: AnyView(TestDoneSwiftUIView(score: totalScore,Testtitle: "복약 순응도 테스트", testContent: "복 약 순응도가 낮은 상황에서는 의사의 처방 및 약사의 복약지도가 환자의 건강상태를 개선시키는 데 어려움이 있습니다. 해당되는 이용자에게는 적절한 복약 알림과 복약 현황 파악을 통해 복약 순응도를 높일 수 있습니다."))) {
                        Text("완료")
                           .font(Font.custom("SUIT", size: 20).weight(.semibold))
                           .frame(maxWidth: .infinity)  // Fill the horizontal direction
                           .foregroundColor(allQuestionsAnswered ? Color.white : Color(red: 0.78, green: 0.78, blue: 0.81))
                           .frame(height: 56)
                           .background(allQuestionsAnswered ? Color(red: 0.15, green: 0.4, blue: 0.96) : Color(UIColor(red: 0.91, green: 0.91, blue: 0.93, alpha: 1)))
                           .cornerRadius(8)
                    }
                    .disabled(!allQuestionsAnswered)
                    .padding(.horizontal,20)
                    
                }
            }
    }
}


struct ConfromityTestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ConfromityTestSwiftUIView()
    }
}
