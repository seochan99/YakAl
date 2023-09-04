import SwiftUI

struct DepressionTestSwiftUIView: View {
    
    // 질문 리스트
    let questions = [
        "일을 하는 것에 대한 흥미나 재미가 거의 없음",
        "가라앉는 느낌, 우울감 또는 절망감",
        "잠들기 어렵거나 자꾸 깨어남, 혹은 너무 많이 잠",
        "피곤함, 기력이 저하됨",
        "식욕 저하 혹은 과식",
        "내 자신이 나쁜 사람이라는 느낌 혹은 내 자신을 실패자라고 느끼거나, 나 때문에 나 자신이나 내 가족이 불행하게 되었다는 느낌",
        "신문을 읽거나 TV를 볼 때 집중하기 어려움",
        "남들이 알아챌 정도로 거동이나 말이 느림. 또는 반대로 너무 초조하고 안절부절못해서 평소보다 많이 돌아다니고 서성거림",
        "나는 차라리 죽는 것이 낫겠다는 등의 생각, 혹은 어떤 식으로든 스스로를 자해하는 생각들",
    ]
    
    let options = ["전혀 아님", "2~6일", "7일 이상", "거의 매일"]
    // 각 질문에 대한 선택을 저장하는 배열
    @State private var selectedOptions = Array(repeating: nil as String?, count: 9)
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
                  return score + 0
              case options[1]:
                  return score + 1
              case options[2]:
                  return score + 2
              case options[3]:
                  return score + 3
              default:
                  return score
              }
          }
      }
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false){
                VStack(spacing:64){
                    InfoBoxView(title: "우울증 선별검사 (PHQ-9)", content: "이용자의 우울 여부는 일상생활의 동기부여나 의약품 복약 준수도에 영향을 미칠 수 있습니다. 이용자의 상태를 파악하여 심리 상담 등 도움을 드릴 수 있습니다.")
                    
                    
                    
                    
                    VStack(alignment: .leading,spacing: 80) {
                        Text("지난 2주 동안 아래에 나열되는 증상에 얼마나 자주 시달렸습니까?")
                          .font(
                            Font.custom("SUIT", size: 16)
                              .weight(.bold)
                          )
                          .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                          .padding(.horizontal,20)
                        
                        ForEach(questions.indices, id: \.self) { index in
                            RowQuestionView(index: index, question: questions[index],options: self.options, selectedOption: $selectedOptions[index])
                        }
                    }.padding(.horizontal,20)
                    
                    NavigationLink(destination: AnyView(TestDoneSwiftUIView(score: totalScore,Testtitle: "우울증 선별검사 (PHQ-9)", testContent: "총점이 10점 이상으로 주요우울장애가 의심되거나 9번 문항을 1점 이상으로 응답한 경우(즉, 자살/자해 생각이 있는 경우) 가까운 병∙ 의원에서 진료를 받거나, 정신건강복지센터(또는 정신건강 위기상담전화)에서 상담을 받을 필요가 있습니다!\n\n가벼운 우울상태인 이용자들은 규칙적인 생활습관과 충분한 수면, 그리고 운동하는 습관을 통해 개선될 수 있습니다."))) {
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
        }.navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}

struct DepressionTestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DepressionTestSwiftUIView()
    }
}
