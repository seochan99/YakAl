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
    var isEnabled: Bool = true


        var body: some View {
            Button(action: action) {
                Text(text)
                   .font(Font.custom("SUIT", size: 20).weight(.semibold))
                   .frame(maxWidth: .infinity)  // Fill the horizontal direction
                   .foregroundColor(isEnabled ? Color.white : Color(red: 0.78, green: 0.78, blue: 0.81))
                   .frame(height: 56)
                   .background(isEnabled ? Color(red: 0.15, green: 0.4, blue: 0.96) : Color(UIColor(red: 0.91, green: 0.91, blue: 0.93, alpha: 1)))
                   .cornerRadius(8)
            }
            .disabled(!isEnabled)
            .padding(.horizontal, 20)  // Add 20 margin on both sides
        }
}

struct BlueHorizontalButton_Previews: PreviewProvider {
    static var previews: some View {
        BlueHorizontalButton(text:"완료",action: {},isEnabled:false)
    }
}
