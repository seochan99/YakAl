import SwiftUI

struct MypageSwiftUIView: View {
    @ObservedObject private var user = User.shared
    @State private var showEditNicknameModal: Bool = false
    @State private var editedNickname: String = ""

    
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
                            showEditNicknameModal.toggle()

                        }.padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color(red: 0.91, green: 0.91, blue: 0.93))
                            .cornerRadius(8)
                            .font(Font.custom("SUIT", size: 14).weight(.medium))
                            .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))

                    }.padding(.top, 60)
                    .padding(.horizontal, 20)
                    .sheet(isPresented: $showEditNicknameModal) {
                        EditNicknameView(nickname: $editedNickname, onDismiss: {
                            showEditNicknameModal = false
                            user.nickName = editedNickname
                        })
                    }
                    
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
                    //-------------------- Scorll View --------------------
                    ZStack {
                        Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1).edgesIgnoringSafeArea(.all)
                        ScrollView {
                            
                            Button(action: {}) {
                                HStack{
                                    Text("자가 진단 테스트")
                                      .font(
                                        Font.custom("SUIT", size: 16)
                                          .weight(.bold)
                                      )
                                      .foregroundColor(.white)
                                    Spacer()
                                    Text("\(user.testCnt)/6")
                                      .font(
                                        Font.custom("SUIT", size: 20)
                                          .weight(.semibold)
                                      )
                                      .foregroundColor(.white)
                                }
                            }.padding(.horizontal, 24)
                                .padding(.vertical, 28)
                                .background(Color(red: 0.15, green: 0.4, blue: 0.96))
                                .cornerRadius(16)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 28)
                            VStack(spacing: 0){
                                SettingButton(action: {
                                    // 버튼을 클릭했을 때의 액션
                                }, imageName: "gear", title: "앱 설정")
                                SettingButton(action: {
                                    // 버튼을 클릭했을 때의 액션
                                }, imageName: "bell", title: "알림 설정")
                                SettingButton(action: {
                                    // 버튼을 클릭했을 때의 액션
                                }, imageName: "house-home", title: "내 위치 설정")
                            }
                            VStack(spacing: 0){
                                SettingButton(action: {
                                    // 버튼을 클릭했을 때의 액션
                                }, imageName: nil, title: "약알에게 바라는 점")
                                SettingButton(action: {
                                    // 버튼을 클릭했을 때의 액션
                                }, imageName: nil, title: "자주묻는 질문")
                                    HStack {
                                        Text("버전 정보")
                                            .font(Font.custom("SUIT", size: 16).weight(.medium))
                                            .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                                        Spacer()
                                        Text("v0.0.1")
                                          .font(
                                            Font.custom("SUIT", size: 14)
                                              .weight(.medium)
                                          )
                                          .multilineTextAlignment(.trailing)
                                          .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))

                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical,15)
                                    .background(Color(red: 1, green: 1, blue: 1))
                                }

                            VStack(spacing: 0){
                                SettingButton(action: {
                                    // 버튼을 클릭했을 때의 액션
                                }, imageName: nil, title: "전문가 인증")
                            }
                        }.background(Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1))
                            
                    }
                }
                
            }
            
        }
}

struct EditNicknameView: View {
    @ObservedObject private var user = User.shared
    @Binding var nickname: String
    var onDismiss: () -> Void
    @State private var isEditing: Bool = false // 추가


    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                VStack(alignment: .leading) { // 왼쪽 정렬을 위해 VStack에 alignment 추가
                    Text("닉네임 수정")
                      .font(Font.custom("SUIT", size: 20).weight(.bold))
                      .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                    
                    Text("약알이 어떻게 불러드릴까요?")
                      .font(Font.custom("SUIT", size: 13).weight(.medium))
                      .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                }
                
                Spacer() // 왼쪽과 오른쪽 요소 사이에 최대 공간을 넣음
                VStack{
                    Button(action: onDismiss) {
                        Image(systemName: "xmark")
                    }
                    .padding()
                }
            }.padding(.top, 40)
            
            /* ----------- 닉네임 입력 ----------- */
            TextField("닉네임 입력", text: $nickname, onEditingChanged: { editing in
                   isEditing = editing
               })
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                       RoundedRectangle(cornerRadius: 8)
                           .inset(by: 1)
                           .stroke(isEditing ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color.gray, lineWidth: 2)
                   )

            /* ----------- 완료 버튼 ----------- */
            BlueHorizontalButton(text: "완료"){
                user.nickName = nickname
                onDismiss()
            }
        }.padding(.horizontal, 20)  // 양쪽에 마진 20 추가
        Spacer()
    }
}

struct MypageSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MypageSwiftUIView()
    }
}
