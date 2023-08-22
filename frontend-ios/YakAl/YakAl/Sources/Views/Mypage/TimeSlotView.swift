//
//  TimeSlotView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/23.
//

import SwiftUI


/* --------------- 시간 열 컴포넌트 --------------- */
struct TimeSlotView: View {
    var iconName: String
    var label: String
    @Binding var startTime: Date
    @Binding var endTime: Date

    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return "\(formatter.string(from: startTime)) - \(formatter.string(from: endTime))"
    }

    var body: some View {
        NavigationLink(destination: TimeSettingView(startTime: $startTime, endTime: $endTime, title: label, iconName: iconName)) {
            HStack(spacing: 8) {
                Image(iconName)
                    .resizable()
                    .frame(width: 20, height: 20)
                
                HStack(spacing: 24) {
                    Text(label)
                        .font(Font.custom("SUIT", size: 16).weight(.medium))
                        .foregroundColor(.black)
                    
                    Text(formattedTime)
                        .font(Font.custom("SUIT", size: 15).weight(.medium))
                        .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(Color(UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)))

            }
        }
    }
}

