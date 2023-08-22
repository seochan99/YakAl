//
//  WeekdayHeaderSwiftUIView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/22.
//

import SwiftUI

// 분리한 요일 헤더 뷰
struct WeekdayHeaderSwiftUIView: View {
    let weekStringdate : [String] = ["일","월","화","수","목","금","토"]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(weekStringdate, id: \.self) { symbol in
                Text(symbol)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(weekdayColor(for: symbol))
            }
        }.padding(.horizontal,20)
    }
    
    func weekdayColor(for weekdayText: String) -> Color {
        switch weekdayText {
            case "일":
                return Color(red: 0.88, green: 0.06, blue: 0.16) // 일요일 색상
            case "토":
                return Color(red: 0.33, green: 0.53, blue: 0.99) // 토요일 색상
            default:
                return Color.black // 기본 색상
        }
    }
}

struct WeekdayHeaderSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayHeaderSwiftUIView()
    }
}
