//
//  LogoutModalView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/09/05.
//

import SwiftUI

struct LogoutModalView: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            Text("로그아웃 하시겠습니까?")
              .font(
                Font.custom("SUIT", size: 20)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
              .padding(.top,36)
            
            HStack(spacing:8) {
                Button(action: {
                    isPresented = false
                }) {
                    Text("아니요")
                        .font(Font.custom("SUIT", size: 20)
                        .weight(.semibold))
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.93))
                        .cornerRadius(8)
                }
                Button(action: {
                    
                    isPresented = false
                }) {
                    Text("로그아웃")
                        .font(Font.custom("SUIT", size: 20)
                        .weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color(red: 0.15, green: 0.4, blue: 0.96))
                        .cornerRadius(8)
                }
            }
            .padding(.top,33)
            .padding(.horizontal,16)

                
            
        }
        .padding(.vertical,17)
        .frame(width: 340)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.45).opacity(0.2), radius: 3, x: 0, y: 2)
    }
}

//struct LogoutModalView_Previews: PreviewProvider {
//    static var previews: some View {
////        LogoutModalView()
//    }
//}
