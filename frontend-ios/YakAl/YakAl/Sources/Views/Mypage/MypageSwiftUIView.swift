import SwiftUI

struct MypageSwiftUIView: View {
    @State private var user = User.shared

    var body: some View {
        NavigationView {
            
            //-------------------- 이름 및 정보 View --------------------
                VStack(spacing: 20) {
                    /*-------------------- 이름 및 수정버튼 --------------------*/
                    HStack{
                        VStack(alignment: .leading, spacing: 5){
                            Text("\(user.nickName.isEmpty ? "약알" : user.nickName)님,")
                              .font(
                                Font.custom("SUIT", size: 20)
                                  .weight(.bold)
                              )
                              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                            Text("약알과 함께 건강하세요!")
                              .font(
                                Font.custom("SUIT", size: 20)
                              )
                              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                        }
                        Spacer()
                        Button("수정"){
                            
                        }.padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.91, green: 0.91, blue: 0.93))
                            .cornerRadius(8)
                            .font(Font.custom("SUIT", size: 14).weight(.medium))
                            .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))

                    }.padding(.top, 45)
                    .padding(.horizontal, 20)
                    
                    /*-------------------- 전문가 공유 버튼 --------------------*/
                    Button(action: {
                        // 버튼 액션
                    }) {
                        HStack {
                            HStack(spacing:8){
                                Image("icon-health")
                                Text("전문가에게 복약정보 공유")
                                    .font(Font.custom("SUIT", size: 16).weight(.medium))
                                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(UIColor(red: 0.56, green: 0.56, blue: 0.62, alpha: 1)))
                        }
                        .padding(.horizontal, 20) // 양옆 margin 20
                        .frame(height: 36)
                        .background(Color(red: 0.96, green: 0.96, blue: 0.98))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 1)
                        )
                        
                    }.padding(.horizontal, 20) // 양옆 margin 20
                        .padding(.vertical,20) // 양옆 margin 20
                    Divider().padding(.vertical, 1)
                    //-------------------- Scorll View --------------------
                    ZStack {
                        Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1).edgesIgnoringSafeArea(.all)
                        ScrollView {
                            Button("자가진단 테스트 \(user.testCnt)/6") {
                                
                            }
                            Button("앱설정") {
                                // 앱설정 버튼 액션
                            }
                            Button("알림설정") {
                                // 알림설정 버튼 액션
                            }
                            Button("내 위치 설정") {
                                // 내 위치 설정 버튼 액션
                            }
                            
                            
                            Button("약알에게 바라는 점") {
                                // 약알에게 바라는 점 버튼 액션
                            }
                            Button("자주 묻는 질문") {
                                // 자주 묻는 질문 버튼 액션
                            }
                            Button("버전 정보") {
                                // 버전 정보 버튼 액션
                            }
                            Button("전문가 인증") {
                                // 전문가 인증 버튼 액션
                            }
                        }.background(Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1))
                            
                    }
                }
                
            }
            
        }
}

struct MypageSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MypageSwiftUIView()
    }
}
