import SwiftUI

struct SignOutSwiftUIView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack{
            // 이미지
            Image("default_circle")
                .frame(width: 56, height: 56)
                .padding(.top,30)
            // 탈퇴
            Text("정말 탈퇴하시겠어요?")
              .font(
                Font.custom("SUIT", size: 20)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
              .padding(.top,20)
              .padding(.bottom,60)
            
            VStack(alignment: .leading,spacing: 16){
                Text("※ 탈퇴시 유의사항")
                  .font(
                    Font.custom("SUIT", size: 16)
                      .weight(.semibold)
                  )
                  .foregroundColor(.black)
                  
                Text("""
                · 약알 앱 진행 중일 경우(인앱 결제 등)탈퇴가 불가합니다.
                                 
                · 댓글, 좋아요, 내가 쓴 글 등 기타 아이디와 연계된 모든 정보를 삭제합니다.\n\n · 탈퇴한 회원은 60일동안 해당 아이디 기준으로 재가입이 불가하고 일정기간 동안 재가입 및 동일 아이디 사용이 불가합니다.\n\n · 회원 탈퇴 일로부터 닉네임을 포함한 계정 정보(아이디/휴대폰 번호/ 등록된 카드 등)는 '개인 정보 보호 정책'에 따라 60일간 보관되며, 60일이 경과한 후에는 모든 개인정보는 완전히 삭제되며 더 이상 복구할 수 없습니다.
                """)
                  .font(
                    Font.custom("SUIT", size: 14)
                      .weight(.medium)
                  )
                  .foregroundColor(.black)
                  .frame(width: 308, alignment: .topLeading)
            }
            .frame(maxWidth:.infinity)
            .padding(.vertical,24)
            .foregroundColor(.clear)
                .background(Color(red: 0.96, green: 0.96, blue: 0.98))
                .cornerRadius(8)
            
            HStack{
                // 취소, 뒤로 감
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("취소")
                              .font(
                                Font.custom("SUIT", size: 20)
                                  .weight(.semibold)
                              )
                              .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                                .padding(.horizontal, 32)
                                .padding(.vertical, 18)
//                                .frame(minWidth: 0, alignment: .center)

                                .background(Color(red: 0.91, green: 0.91, blue: 0.93))
                                .cornerRadius(8)
                        }
                // 탈퇴하기 버튼, 탈퇴처리 진행
                Button(action: {
                                   // 여기에 탈퇴 처리 코드를 추가하세요
                               }) {
                                   Text("탈퇴하기")
                                     .font(
                                       Font.custom("SUIT", size: 20)
                                         .weight(.semibold)
                                     )
                                     .foregroundColor(.white)
                                       .padding(.horizontal, 80)
                                       .padding(.vertical, 18)
                                       .frame(minWidth: 0, maxWidth: .infinity)
                                       .background(Color(red: 0.98, green: 0.36, blue: 0.36))
                                       .cornerRadius(8)
                               }
            }            .padding()

        }.padding(.horizontal,20)
            .navigationTitle("회원 탈퇴")
        
    }
}

struct SignOutSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutSwiftUIView()
    }
}
