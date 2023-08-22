//
//  CalendarHeaderChangeMonthSwiftUIView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/22.
//

import SwiftUI

struct CalendarHeaderChangeMonthSwiftUIView: View {
    
    // Use Binding for properties that will change outside of this View.
    @Binding var currentDate: Date

    // DateFormatter for displaying month and year
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월"
        return formatter
    }

    var body: some View {
        HStack(spacing:20) {
            Spacer()
            // --------------- 이전버튼  ---------------
            Button(action: {
                self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate) ?? self.currentDate
            }) {
                Image("previous-month")
            }
            // --------------- 년/월  ---------------
            Text(dateFormatter.string(from: currentDate))
                .font(
                    Font.custom("SUIT", size: 15)
                        .weight(.semibold)
                )
                .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
            // --------------- 다음버튼  ---------------
            Button(action: {
                self.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentDate) ?? self.currentDate
            }) {
                Image("next-month")
            }
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, 15)
    }
}

struct CalendarHeaderChangeMonthSwiftUIView_Previews: PreviewProvider {
    @State static var previewDate = Date()

    static var previews: some View {
        CalendarHeaderChangeMonthSwiftUIView(currentDate: $previewDate)
    }
}
