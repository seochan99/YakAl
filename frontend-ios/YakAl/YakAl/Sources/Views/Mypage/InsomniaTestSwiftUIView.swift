//
//  InsomniaTestSwiftUIView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/09/03.
//

import SwiftUI

struct InsomniaTestSwiftUIView: View {
    @State private var selectedOptions = Array(repeating: nil as String?, count: 7)
    // 질문 리스트
    let questions = [
        "잠들기 어렵나요?",
        "잠을 유지하기 어렵나요?",
        "잠에서 쉽게 깨나요?",
        "현재 수면 양상에 얼마나 만족하고 있나요?",
        "당신의 수면장애를 다른 사람들이 걱정하나요?",
        "당신은 현재 불면증에 대해서 걱정하고 있나요?",
        "당신의 수면장애가 어느 정도나 당신의 낮의 활동을 방해한다고 생각하나요?",
    ]
    
    let options = ["매우 그렇다", "그렇다", "보통", "아니다", "전혀 아니다"]
    
    // 모든 문항이 선택되었는지 확인
    var allQuestionsAnswered: Bool {
        return !selectedOptions.contains { $0 == nil || $0!.isEmpty }
    }
    
    // 점수 계산
    var totalScore: Int {
        var score = 0
        for (index, option) in selectedOptions.enumerated() {
            if let option = option {
                if questions[index] == "현재 수면 양상에 얼마나 만족하고 있나요?" {
                    switch option {
                    case options[0]:
                        score += 4
                    case options[1]:
                        score += 3
                    case options[2]:
                        score += 2
                    case options[3]:
                        score += 1
                    case options[4]:
                        score += 0
                    default:
                        break
                    }
                } else {
                    switch option {
                    case options[0]:
                        score += 0
                    case options[1]:
                        score += 1
                    case options[2]:
                        score += 2
                    case options[3]:
                        score += 3
                    case options[4]:
                        score += 4
                    default:
                        break
                    }
                }
            }
        }
        return score
    }

    
    var body: some View {
        NavigationView{
            
            
            ScrollView(showsIndicators:false){
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
                    NavigationLink(destination: AnyView(TestDoneSwiftUIView(score: totalScore,Testtitle: "불면증 심각도", testContent: "충분한 수면과 좋은 수면의 질은 이용자의 건강에 중요한 요소입니다. 이 설문에서 높은 점수를 받을수록 불면증이 심한 상태이기 때문에 수면 클리닉이나 의료기관을 방문하여 적절한 치료가 필요합니다."))) {
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

struct InsomniaTestSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        InsomniaTestSwiftUIView()
    }
}
