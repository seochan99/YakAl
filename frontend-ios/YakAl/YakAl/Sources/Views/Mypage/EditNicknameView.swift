//
//  EditNicknameView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/09/05.
//

import SwiftUI

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
