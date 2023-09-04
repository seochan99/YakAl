import SwiftUI

//MARK: - 테스트 상태
enum TestStatus {
    case inProgress, incomplete, complete
}

//MARK: - 테스트 버튼 뷰
struct TestButton: View {
    let testName: String
    let status: TestStatus
    let destination: AnyView

    
    var body: some View {
        NavigationLink(destination: destination) {
                HStack {
                    Text(testName)
                        .font(Font.custom("SUIT", size: 14).weight(.medium))
                        .foregroundColor(.black)
                    
                    Spacer()
                    Text(textForStatus(status))
                        .font(Font.custom("SUIT", size: 14).weight(.medium))
                        .foregroundColor(status == .inProgress ? Color(red: 0.33, green: 0.53, blue: 0.99) : .black)
                    
                }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(colorForStatus(status), lineWidth: 2)
            )
        }
    }
    
    private func textForStatus(_ status: TestStatus) -> String {
        switch status {
        case .inProgress:
            return "진행중"
        case .incomplete:
            return "미완료"
        case .complete:
            return "완료"
        }
    }
    
    private func colorForStatus(_ status: TestStatus) -> Color {
        switch status {
        case .inProgress:
            return Color(red: 0.33, green: 0.53, blue: 0.99)
        case .incomplete, .complete:
            return Color(red: 0.91, green: 0.91, blue: 0.93)
        }
    }
}

struct TestListSwiftUIView: View {
    //TestStatus.complete는 현재 더미데이터
    let tests = [
        ("북약 순응도 테스트", TestStatus.complete, AnyView(ConfromityTestSwiftUIView())),
             ("우울증 선별검사 (PHQ-9)", TestStatus.incomplete, AnyView(DepressionTestSwiftUIView())),
             ("음주력 테스트", TestStatus.inProgress, AnyView(DrinkingTestSwiftUIView())),
             ("흡연력 테스트", TestStatus.incomplete, AnyView(SmokingTestSwiftUIView())),
             ("불면증 심각도", TestStatus.complete, AnyView(InsomniaTestSwiftUIView())),
             ("현재 복용 중인 건강기능식품", TestStatus.inProgress, AnyView(HealthFoodSwiftUIView())),
             ("1년간 처방 받은 병의 진단명", TestStatus.incomplete, AnyView(DiagnosticTestSwiftUIView()))
      ]
      
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ForEach(tests, id: \.0) { testName, status, destination in
                    TestButton(testName: testName, status: status, destination: destination)
                }.padding(.horizontal,20)
                Spacer()
                BlueHorizontalButton(text: "완료된 결과 공유", action: {})
            }
            .padding(.top,40)
            
        }
    }
     
}

struct TestListSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestListSwiftUIView()
    }
}
