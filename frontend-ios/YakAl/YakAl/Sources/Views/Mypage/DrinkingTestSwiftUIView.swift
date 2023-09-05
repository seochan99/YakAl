import SwiftUI

struct DrinkingTestSwiftUIView: View {
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var selectedAnswer: Int?
    @State private var allQuestionsAnswered = false


    let questions = [
        Question(title: "얼마나 술을 자주 마십니까?", answers: [
            Answer(text: "전혀 안 마심", score: 0),
            Answer(text: "월 1회 미만", score: 1),
            Answer(text: "월 2~4회", score: 2),
            Answer(text: "주 2~3회", score: 3),
            Answer(text: "주 4회 이상", score: 4)
        ]),
        Question(title: "술을 마시는 날은 한 번에 몇 잔 정도 마십니까?", answers: [
            Answer(text: "1~2잔", score: 0),
            Answer(text: "3~4잔", score: 1),
            Answer(text: "5~6잔", score: 2),
            Answer(text: "7~9잔", score: 3),
            Answer(text: "10잔 이상", score: 4)
        ]),
        Question(title: "한 번의 좌석에서 소주 한 병 또는 맥주 4병 이상 마시는 경우는 얼마나 자주 있습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "월 1회 미만", score: 1),
            Answer(text: "월 1회", score: 2),
            Answer(text: "주 1회", score: 3),
            Answer(text: "거의 매일", score: 4)
        ]),
        Question(title: "지난 1년간 한번 술을 마시기 시작하면 멈출 수 없었던 때가 얼마나 자주 있었습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "월 1회 미만", score: 1),
            Answer(text: "월 1회", score: 2),
            Answer(text: "주 1회", score: 3),
            Answer(text: "거의 매일", score: 4)
        ]),
        Question(title: "지난 1년간 평소 같으면 할 수 있던 일을 음주 때문에 실패한 적이 얼마나 자주 있었습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "월 1회 미만", score: 1),
            Answer(text: "월 1회", score: 2),
            Answer(text: "주 1회", score: 3),
            Answer(text: "거의 매일", score: 4)
        ]),
        Question(title: "지난 1년간 술을 마신 다음날 일어나기 위해 해장술이 필요했던 적은 얼마나 자주 있었습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "월 1회 미만", score: 1),
            Answer(text: "월 1회", score: 2),
            Answer(text: "주 1회", score: 3),
            Answer(text: "거의 매일", score: 4)
        ]),
        Question(title: "지난 1년간 음주 후에 죄책감이 든 적이 얼마나 자주 있었습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "월 1회 미만", score: 1),
            Answer(text: "월 1회", score: 2),
            Answer(text: "주 1회", score: 3),
            Answer(text: "거의 매일", score: 4)
        ]),
        Question(title: "지난 1년간 음주 때문에 전날 밤에 있었던 일이 기억나지 않았던 적이 얼마나 자주 있었습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "월 1회 미만", score: 1),
            Answer(text: "월 1회", score: 2),
            Answer(text: "주 1회", score: 3),
            Answer(text: "거의 매일", score: 4)
        ]),
        Question(title: "음주로 인해 자신이나 다른 사람이 다친 적이 있었습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "지난 1년간 없음", score: 2),
            Answer(text: "지난 1년간 있음", score: 4),
        ]),
        Question(title: "친척이나 친구, 의사가 당신이 술 마시는 것을 걱저하거나 당신에게 술 끊기를 권유한 적이 있었습니까?", answers: [
            Answer(text: "없음", score: 0),
            Answer(text: "지난 1년간 없음", score: 2),
            Answer(text: "지난 1년간 있음", score: 4),
        ]),
        
        // 추가 질문은 여기에 추가하세요
    ]

    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 64) {
                    InfoBoxView(title: "음주력 테스트", content: "이용자의 음주 습관과 빈도를 파악하기 위한 설문입니다.")
                    
                    //문제 제목, 항목
                    VStack {
                        
                        // 설문 문제
                        Text("\(currentQuestionIndex+1). \(questions[currentQuestionIndex].title)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(
                                Font.custom("SUIT", size: 15)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                            .padding(.horizontal,32)
                            .padding(.bottom,16)
                        
                        
                        
                        // Answer 반복문
                        ForEach(0..<questions[currentQuestionIndex].answers.count, id: \.self) { index in
                            Button(action: {
                                selectedAnswer = index
                            }) {
                                VStack{
                                    Text(questions[currentQuestionIndex].answers[index].text)
                                        .frame(maxWidth: .infinity)
                                        .frame(height:60)
                                        .background(selectedAnswer == index ? Color(red: 0.95, green: 0.96, blue: 1) : .white)
                                        .foregroundColor(selectedAnswer == index ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.38, green: 0.38, blue: 0.45))
                                        .cornerRadius(8)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height:60)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 1)
                                        .stroke(selectedAnswer == index ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 2)
                                )
                                .padding(.horizontal,32)
                                
                                
                                
                            }
                            .padding(.bottom, 15)
                        }
                    }
                    
                    // 다음버튼
                    if currentQuestionIndex < questions.count - 1 {
                                       BlueHorizontalButton(text: "다음", action: {
                                           if let selectedAnswer = selectedAnswer {
                                               score += questions[currentQuestionIndex].answers[selectedAnswer].score
                                               if currentQuestionIndex < questions.count - 1 {
                                                   currentQuestionIndex += 1
                                                   self.selectedAnswer = nil
                                               }
                                           }
                                       }, isEnabled: selectedAnswer != nil)
                                   } else {
                                       NavigationLink(destination: AnyView(TestDoneSwiftUIView(score: score, Testtitle: "음주력 테스트", testContent: "이 설문에서 높은 점수일수록 이용자의 음주 습관이 위험함을 의미합니. 음주 습관은 건강상태에 큰 영향을 끼칠 수 있습니다. 의존적인 음주습관을 가질 경우 가까운 센터를 방문하여 지속적인 상담 및 약물 치료가 필요합니다."))) {
                                           Text("완료")
                                               .font(Font.custom("SUIT", size: 20).weight(.semibold))
                                               .frame(maxWidth: .infinity)  // Fill the horizontal direction
                                               .foregroundColor(!allQuestionsAnswered ? Color.white : Color(red: 0.78, green: 0.78, blue: 0.81))
                                               .frame(height: 56)
                                               .background(!allQuestionsAnswered ? Color(red: 0.15, green: 0.4, blue: 0.96) : Color(UIColor(red: 0.91, green: 0.91, blue: 0.93, alpha: 1)))
                                               .cornerRadius(8)
                                       }
                                       .padding(.horizontal,20)
                                   }
                    
                }
            }
//        }.navigationBarTitle("", displayMode: .inline)
//            .navigationBarBackButtonHidden(true)
    }
}

struct Question {
    let title: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let score: Int
}


struct DrinkingTestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkingTestSwiftUIView()
    }
}
