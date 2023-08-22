//
//  BlueHorizontalButton.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/23.
//

import SwiftUI

struct BlueHorizontalButton: View {
    var text: String
        var action: () -> Void

        var body: some View {
            Button(action: action) {
                Text(text)
                    .font(Font.custom("SUIT", size: 20).weight(.semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)  // Fill the horizontal direction
                    .frame(height: 56)
                    .background(Color(red: 0.15, green: 0.4, blue: 0.96))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)  // Add 20 margin on both sides
        }
}

struct BlueHorizontalButton_Previews: PreviewProvider {
    static var previews: some View {
        BlueHorizontalButton(text:"완료",action: {})
    }
}
