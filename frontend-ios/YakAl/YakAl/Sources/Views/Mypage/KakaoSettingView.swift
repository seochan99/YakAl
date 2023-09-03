import SwiftUI





struct AccountSettingsView: View {
    @State private var isLoggedIn = true  // Assuming the user is logged in when they see this view
    @Binding var showLogoutModal: Bool
    private var logoutCoordinator = LogoutCoordinator()
    
    init(showLogoutModal: Binding<Bool>) {
        self._showLogoutModal = showLogoutModal
    }


    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 30) {
                HStack {
                    Text("계정 설정")
                        .font(Font.custom("SUIT", size: 20).weight(.bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                
                VStack(spacing: 30) {
                    Button(action: {
                        showLogoutModal = true
                    }) {
                        HStack {
                            Text("로그아웃")
                                .font(Font.custom("SUIT", size: 16).weight(.medium))
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)))
                        }
                    }
                    Button(action: logout) {
                        HStack {
                            Text("회원탈퇴")
                                .font(Font.custom("SUIT", size: 16).weight(.medium))
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)))
                        }
                    }
                    // 회원탈퇴 button can be similarly implemented
                    LogoutController(coordinator: logoutCoordinator)  // Add this
                    
                }
            }
            .padding(.top, 40)
            

        }
    
    }
    func logout() {
        logoutCoordinator.logoutAndTransitionToMainVC()
    }
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy binding for the preview
        let dummyBinding = Binding<Bool>(get: { false }, set: { _ in })
        return AccountSettingsView(showLogoutModal: dummyBinding)
    }
}

