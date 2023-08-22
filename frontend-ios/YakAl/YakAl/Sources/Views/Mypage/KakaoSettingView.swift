import SwiftUI
import KakaoSDKUser

class LogoutCoordinator: NSObject, UINavigationControllerDelegate {
    func logoutAndTransitionToMainVC() {
        UserApi.shared.logout { error in
            if let error = error {
                print(error)
            } else {
                UserDefaults.standard.removeObject(forKey: "KakaoAccessToken")
                print("logout() success.")
                
                if let window = UIApplication.shared.windows.first,
                   let storyboard = UIStoryboard(name: "MainVC", bundle: nil).instantiateInitialViewController() {
                    window.rootViewController = storyboard
                    window.makeKeyAndVisible()
                }
            }
        }
    }
}


struct LogoutController: UIViewRepresentable {
    typealias UIViewType = UIView
    
    var coordinator: LogoutCoordinator
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // This space intentionally left blank
    }
    
    func makeCoordinator() -> LogoutCoordinator {
        return coordinator
    }
}


struct AccountSettingsView: View {
    @State private var isLoggedIn = true  // Assuming the user is logged in when they see this view
    private var logoutCoordinator = LogoutCoordinator()

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Text("계정 설정")
                    .font(Font.custom("SUIT", size: 20).weight(.bold))
                    .foregroundColor(.black)
                Spacer()
            }

            VStack(spacing: 30) {
                Button(action: logout) {
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

    func logout() {
         logoutCoordinator.logoutAndTransitionToMainVC()
     }
}
