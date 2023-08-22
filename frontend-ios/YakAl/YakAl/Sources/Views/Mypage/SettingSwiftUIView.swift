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
                    VStack(alignment: .leading, spacing: 30) {
                        
                        VStack(spacing:16){
                            
                            
                            /* --------------- 시간 설정 헤더 --------------- */
                            HStack {
                                Text("시간 설정")
                                    .font(Font.custom("SUIT", size: 20).weight(.bold))
                                    .foregroundColor(.black)
                                Spacer() // This pushes the Text view to the left (leading edge)
                            }
                            /* --------------- 시간 설정 부연설명 --------------- */
                            HStack{
                                Text("나의 루틴에 맞추어 시간을 조정할 수 있습니다.")
                                    .font(
                                        Font.custom("SUIT", size: 15)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                                Spacer() // This pushes the Text view to the left (leading edge)
                            }
                            
                        }
                        VStack(spacing:30) {
                            TimeSlotView(iconName: "icon-morning", label: "아침", startTime: $morningStartTime, endTime: $morningEndTime)
                            TimeSlotView(iconName: "icon-afternoon", label: "점심", startTime: $noonStartTime, endTime: $noonEndTime)
                            TimeSlotView(iconName: "icon-evening", label: "저녁", startTime: $eveningStartTime, endTime: $eveningEndTime)
                        }
                    }.padding(.top, 40)
                    /* --------------- 계정 설정 헤더 --------------- */

                    AccountSettingsView()
                    
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
