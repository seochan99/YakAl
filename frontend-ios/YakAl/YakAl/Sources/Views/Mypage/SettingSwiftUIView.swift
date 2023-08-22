import SwiftUI

enum Mode {
    case light, regular
}

struct ModeButton: View {
    var mode: Mode
    var title: String
    var description: String


    @Binding var selectedMode: Mode

    var body: some View {
        Button(action: {
            selectedMode = mode
        }) {
            
            VStack {
                HStack{
                    VStack(alignment: .leading,spacing: 16){
                        Text(title)
                            .font(Font.custom("SUIT", size: 24).weight(.medium))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        
                        Text(description)
                            .font(Font.custom("SUIT", size: 15).weight(.bold))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                            

                    }.padding(.horizontal,20)
                    
                    Spacer()
                }

            }
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 20))
            .frame(maxWidth: .infinity)
            .background(selectedMode == mode ? Color(red: 0.95, green: 0.96, blue: 1) : .white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 1)
                    .stroke(selectedMode == mode ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 2)
            )
        }
    }
}

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
    @Environment(\.presentationMode) var presentationMode

    @State private var isSettingStartTime: Bool = false
    @State private var isSettingEndTime: Bool = false

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
        VStack(spacing: 16) {
            HStack{
                TextField("Start Time", text: .constant(formattedStartTime))
                    .onTapGesture {
                        isSettingStartTime = true
                    }
                TextField("End Time", text: .constant(formattedEndTime))
                    .onTapGesture {
                        isSettingEndTime = true
                    }
            }


            if isSettingStartTime {
                DatePicker("Select Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .onDisappear {
                        isSettingStartTime = false
                    }
            }

            if isSettingEndTime {
                DatePicker("Select End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .onDisappear {
                        isSettingEndTime = false
                    }
            }

            Spacer()

            Button("완료") {
                // Navigate back
                isSettingStartTime = false
                isSettingEndTime = false
            }
            
            .disabled(!isValidTime)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .opacity(isValidTime ? 1.0 : 0.5)
        }
        .padding()
        .navigationTitle(title)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                Text("뒤로")
                    .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
        })
    }
}


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
        NavigationLink(destination: TimeSettingView(startTime: $startTime, endTime: $endTime, title: label)) {
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
