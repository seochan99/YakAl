//
//  InfoBoxView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/09/03.
//

import SwiftUI

struct InfoBoxView: View {
    var title: String
    var content: String
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(Font.custom("SUIT", size: 16).weight(.bold))
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                
                Text(content)
                    .font(Font.custom("SUIT", size: 14).weight(.medium))
                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                    .frame(width: 340, alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 74) // Height set to 74
            .padding(.horizontal, 20) // Side padding
            .padding(.vertical, 20) // Vertical padding
            .background(Color(red: 0.96, green: 0.96, blue: 0.98)) // Background color
        
    }
}

struct InfoBoxView_Previews: PreviewProvider {
    static var previews: some View {
        InfoBoxView(title: "복약 순응도 테스트", content: "약알 이용자의 복약 습관과 복약 순응도를 파악하여 의약품 복용에 도움을 드리기 위한 설문입니다.")
    }
}
