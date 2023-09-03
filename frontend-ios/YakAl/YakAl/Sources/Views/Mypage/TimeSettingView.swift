//
//  TimeSettingView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/23.
//

import SwiftUI

/* --------------- 시간 설정 뷰 --------------- */
struct TimeSettingView: View {
    
    @Binding var startTime: Date
    @Binding var endTime: Date
    var title: String
    var iconName: String
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowingAlert = false
    @State private var isShowingDatePicker: Bool = false
    @State private var isSettingStartTime: Bool = true  // Start with startTime by default

    var isValidTime: Bool {
        return startTime < endTime
    }

    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: startTime)
    }

    var formattedEndTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: endTime)
    }

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack(spacing: 60) {
                    HStack(spacing:8){
                        Image(iconName)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(title)
                            .font(Font.custom("SUIT", size: 16).weight(.medium))
                            .foregroundColor(.black)
                    }
                    
                    
                    HStack(spacing:8){
                        Button(action: {
                            isSettingStartTime = true
                            isShowingDatePicker = true
                        }) {
                            Text(formattedStartTime).font(
                                Font.custom("SUIT", size: 16)
                                .weight(.bold)
                                )
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                        }
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 8, height: 2)
                          .background(Color(red: 0.78, green: 0.78, blue: 0.81))

                        Button(action: {
                            isSettingStartTime = false
                            isShowingDatePicker = true
                        }) {
                            Text(formattedEndTime).font(
                                Font.custom("SUIT", size: 16)
                                .weight(.bold)
                                )
                                .multilineTextAlignment(.trailing)
                                .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                        }
                    }
                    
                    Spacer()
                }.padding(.horizontal,20)
                Spacer()
                BlueHorizontalButton(text: "완료") {
                    if isValidTime {
                        isShowingDatePicker = false
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        isShowingAlert = true
                    }
                }

            }
            .padding(.vertical, 30)
           
//            .navigationTitle("시간 설정")
            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }) {
//                Image(systemName: "chevron.left")
//                    .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
//                Text("뒤로")
//                    .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
//            })

            // This is our custom date picker modal
            if isShowingDatePicker {
                DatePickerModalView(isPresented: $isShowingDatePicker, date: isSettingStartTime ? $startTime : $endTime)
            }
        }.alert(isPresented: $isShowingAlert) {
            Alert(title: Text("경고"), message: Text("시작시간이 종료시간보다 뒤에 있습니다."), dismissButton: .default(Text("확인")))
        }
    }
}
