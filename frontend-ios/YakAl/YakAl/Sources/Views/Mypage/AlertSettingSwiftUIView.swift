import SwiftUI

struct AlertSettingSwiftUIView: View {
    @State private var ateAlert: Bool = UserDefaults.standard.bool(forKey: "ateAlert")
    @State private var communityAlert: Bool = UserDefaults.standard.bool(forKey: "communityAlert")
    @State private var marketingAlert: Bool = UserDefaults.standard.bool(forKey: "marketingAlert")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 32){
            alertToggle(title: "복약 알림", subtitle: "등록한 약의 복용 알림", isOn: $ateAlert, key: "ateAlert")
//            alertToggle(title: "커뮤니티 알림", subtitle: "커뮤니티 내의 댓글, 좋아요 등의 알림", isOn: $communityAlert, key: "communityAlert")
//            alertToggle(title: "마케팅 정보 알림", subtitle: "다양한 이벤트, 혜택 알림", isOn: $marketingAlert, key: "marketingAlert")
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 50)
        .navigationTitle("알림 설정")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                        Text("뒤로")
                            .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                    }
                }
            }
        }
    }
    
    // 알림토글
    func alertToggle(title: String, subtitle: String, isOn: Binding<Bool>, key: String) -> some View {
        Toggle(isOn: isOn) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font.custom("SUIT", size: 16).weight(.medium))
                    .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                
                Text(subtitle)
                    .font(Font.custom("SUIT", size: 14).weight(.medium))
                    .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))
            }
        }
        .tint(Color(UIColor(red: 0.15, green: 0.4, blue: 0.96, alpha: 1)))
        .onChange(of: isOn.wrappedValue) { newValue in
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct AlertSettingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AlertSettingSwiftUIView()
    }
}
