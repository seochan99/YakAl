//
//  ConfromityTestDoneSwiftUIView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/09/04.
//

import SwiftUI

struct TestDoneSwiftUIView: View {
    var score: Int
    var Testtitle : String
    var testContent: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
            VStack(spacing:32){
                ResultBoxSwiftUIView(title:self.Testtitle, score: self.score)
                
                Text(self.testContent)
                    .font(
                        Font.custom("SUIT", size: 15)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    .padding(.horizontal,20)
                    .lineSpacing(8)

                Spacer()
                // 다른 테스트하러가기 버튼
                // TestListSwiftUIView페이지로 이동함
                NavigationLink(destination: TestListSwiftUIView()){
                    Text("다른 테스트 하러가기")
                        .font(
                            Font.custom("SUIT", size: 15)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color("MainColor"))
                        .cornerRadius(10)
                }
            }
            .navigationTitle("자가 진단 테스트")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                            Text("뒤로")
                                .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                        }
                    }
                }
            }
    }
}

struct TestDoneSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestDoneSwiftUIView(score: 35, Testtitle:"복약 순응도 테스트",testContent: "복 약 순응도가 낮은 상황에서는 의사의 처방 및 약사의 복약지도가 환자의 건강상태를 개선시키는 데 어려움이 있습니다. 해당되는 이용자에게는 적절한 복약 알림과 복약 현황 파악을 통해 복약 순응도를 높일 수 있습니다.")
    }
}
