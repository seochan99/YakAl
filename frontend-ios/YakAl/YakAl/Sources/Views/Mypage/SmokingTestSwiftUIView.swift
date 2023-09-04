import SwiftUI

struct SmokingTestSwiftUIView: View {
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var selectedAnswer: Int?
    @State private var allQuestionsAnswered = false
    @State private var smokingYears: String = ""
    @State private var dailySmokingAmount: String?
    
    let questions = [
        Question(title: "흡연을 하고 있습니까?", answers: [
            Answer(text: "피우지 않는다", score: 0),
            Answer(text: "과거에 피웠으나 지금은 끊었다", score: 1),
            Answer(text: "현재 피운다", score: 2)
        ]),
        Question(title: "현재 또는 과거에 흡연을 하였으면 몇 년이나 담배를 피우셨습니까?", answers: [
            // 이 부분은 텍스트 입력 필드로 처리해야 합니다.
        ]),
        Question(title: "현재 또는 과거에 흡연을 하였으면 하루 흡연량은 얼마입니까?", answers: [
            Answer(text: "1/2갑 미만", score: 0),
            Answer(text: "1/2~1갑", score: 1),
            Answer(text: "1~2갑", score: 2),
            Answer(text: "2갑 이상", score: 3)
        ])
    ]
    
    var body: some View {
        NavigationView{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 64) {
                    InfoBoxView(title: "흡연력 테스트", content: "이용자의 흡연 여부와 흡연 습관을 파악하기 위한 설문입니다.")
                    
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
                        
                        // 인덱스가 1일때는 input
                        if currentQuestionIndex == 1 {
                            TextField("흡연한 년수를 입력하세요", text: $smokingYears)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding(.horizontal,32)
                                .padding(.bottom, 10)
                        }else {
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
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    
                    if currentQuestionIndex < questions.count - 1 {
                        BlueHorizontalButton(text: "다음", action: {
                            if currentQuestionIndex == 1 {
                                if !smokingYears.isEmpty {
                                    currentQuestionIndex += 1
                                }
                            } else {
                                if let selectedAnswer = selectedAnswer {
                                    score += questions[currentQuestionIndex].answers[selectedAnswer].score
                                    if currentQuestionIndex < questions.count - 1 {
                                        currentQuestionIndex += 1
                                        self.selectedAnswer = nil
                                    }
                                }
                            }
                        }, isEnabled: currentQuestionIndex == 1 ? !smokingYears.isEmpty : selectedAnswer != nil)
                    }else {
                        NavigationLink(destination: AnyView(TestDoneSwiftUIView(score: score, Testtitle: "흡연력 테스트", testContent: "이용자의 흡연은 호흡기에 영향을 미칠 수 있고 강력한 발암물질로써 이용자의 건강상태에 부정적인 영향을 줄 수 있습니다. 의존적인 흡연습관을 가진 경우 가까운 센터를 방문하거나 상담 및 약물치료를 통해 개선할 수 있습니다."))) {
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
        }.navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
    }
}

struct SmokingTestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SmokingTestSwiftUIView()
    }
}
