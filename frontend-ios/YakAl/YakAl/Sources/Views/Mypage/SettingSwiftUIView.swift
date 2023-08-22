import SwiftUI

struct SettingSwiftUIView: View {
    @State private var selectedMode: Mode = .light
    @State private var morningStartTime: Date = Date()
    @State private var morningEndTime: Date = Date().addingTimeInterval(3600 * 4) // 4 hours later for example

    @State private var noonStartTime: Date = Date().addingTimeInterval(3600 * 5) // 5 hours later
    @State private var noonEndTime: Date = Date().addingTimeInterval(3600 * 6) // 6 hours later

    @State private var eveningStartTime: Date = Date().addingTimeInterval(3600 * 11) // 11 hours later
    @State private var eveningEndTime: Date = Date().addingTimeInterval(3600 * 13) // 13 hours later
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    
                    /* --------------- 모드 설정 --------------- */
                    HStack {
                        Text("모드 설정")
                            .font(Font.custom("SUIT", size: 20).weight(.bold))
                            .foregroundColor(.black)
                        Spacer() // This pushes the Text view to the left (leading edge)
                    }
                }.padding(.top, 40)
                VStack(spacing: 20) {
                    ModeButton(mode: .regular,
                               title: "일반 모드",
                               description: "약알의 일반적인 모드입니다.",
                               selectedMode: $selectedMode)
                    ModeButton(mode: .light,
                               title: "라이트 모드",
                               description: "시니어를 위한 쉬운모드입니다.\n다제약물 정보가 포함되어 있습니다.",
                               selectedMode: $selectedMode)
                    /* --------------- 시간 설정 --------------- */
                    VStack(alignment: .leading, spacing: 16) {
                        
                        /* --------------- 시간 설정 헤더 --------------- */
                        HStack {
                            Text("시간 설정")
                                .font(Font.custom("SUIT", size: 20).weight(.bold))
                                .foregroundColor(.black)
                            Spacer() // This pushes the Text view to the left (leading edge)
                        }
                        /* --------------- 시간 설정 부연설명 --------------- */
                        Text("나의 루틴에 맞추어 시간을 조정할 수 있습니다.")
                            .font(
                                Font.custom("SUIT", size: 15)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                        
                        VStack {
                            TimeSlotView(iconName: "icon-morning", label: "아침", startTime: $morningStartTime, endTime: $morningEndTime)
                            TimeSlotView(iconName: "icon-afternoon", label: "점심", startTime: $noonStartTime, endTime: $noonEndTime)
                            TimeSlotView(iconName: "icon-evening", label: "저녁", startTime: $eveningStartTime, endTime: $eveningEndTime)
                        }
                        
                    }.padding(.top, 40)
                    
                    
                }.padding(.vertical,20)
            }.padding(.horizontal,20)
        }
    }
}

struct SettingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingSwiftUIView()
    }
}

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
            .navigationTitle("시간 설정")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                Text("뒤로")
                    .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
            })

            // This is our custom date picker modal
            if isShowingDatePicker {
                DatePickerModalView(isPresented: $isShowingDatePicker, date: isSettingStartTime ? $startTime : $endTime)
            }
        }.alert(isPresented: $isShowingAlert) {
            Alert(title: Text("경고"), message: Text("시작시간이 종료시간보다 뒤에 있습니다."), dismissButton: .default(Text("확인")))
        }
    }
}

//MARK: - DatePickerModalView : 데이터 피커 
struct DatePickerModalView: View {
    @Binding var isPresented: Bool
    @Binding var date: Date

    var body: some View {
        VStack {
            DatePicker("시간 설정", selection: $date, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .padding()
            
            BlueHorizontalButton(text: "Set Time") {
                isPresented = false
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}
