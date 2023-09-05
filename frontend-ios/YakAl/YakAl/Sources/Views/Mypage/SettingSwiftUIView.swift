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

struct ViewControllerKey: EnvironmentKey {
    static let defaultValue: UIViewController? = nil
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { self[ViewControllerKey.self] }
        set { self[ViewControllerKey.self] = newValue }
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

struct SettingSwiftUIView: View {
    @State private var selectedMode: Mode = .light
    @State private var morningStartTime: Date = Date()
    @State private var morningEndTime: Date = Date().addingTimeInterval(3600 * 4) // 4 hours later for example
    @State private var showLogoutModal = false
    @State private var isLoggedIn = true  // Assuming the user is logged in when they see this view
    private var logoutCoordinator = LogoutCoordinator()

    @State private var noonStartTime: Date = Date().addingTimeInterval(3600 * 5) // 5 hours later
    @State private var noonEndTime: Date = Date().addingTimeInterval(3600 * 6) // 6 hours later

    @State private var eveningStartTime: Date = Date().addingTimeInterval(3600 * 11) // 11 hours later
    @State private var eveningEndTime: Date = Date().addingTimeInterval(3600 * 13) // 13 hours later
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?

    
       
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // 뒤로가기 버ㅌ튼
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack{
                    Image(systemName: "chevron.backward")    // back button 이미지
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                    Text("뒤로")
                        .font(
                            Font.custom("SUIT", size: 14)
                                .weight(.semibold)
                        )
                        .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                }
            }
    }

    func hideTabBar() {
        if let tabBarController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UITabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
       
    func showTabBar() {
        if let tabBarController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UITabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
    
    var body: some View {
        ZStack{
                ScrollView(showsIndicators: false){
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
                                Button(action: {}) {
                                    HStack {
                                        Text("회원탈퇴")
                                            .font(Font.custom("SUIT", size: 16).weight(.medium))
                                            .foregroundColor(.black)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color(UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)))
                                    }
                                }
                            }
                        }
                        .padding(.top, 40)
                        
                    }.padding(.vertical,20)

                }.padding(.horizontal,20)
                    .overlay(
                        Group {
                            if showLogoutModal {
                                // Semi-transparent background
                                Color.black.opacity(0.4)
                                    .edgesIgnoringSafeArea(.all)
                                    .onTapGesture {
                                        showLogoutModal = false
                                    }
                                
                                // Modal view
                                LogoutModalView(isPresented: $showLogoutModal)
                            }
                        }
                    )
            }.onAppear {
                self.hideTabBar()
            }
            .onDisappear {
                self.showTabBar()
            }
    }
    
}
struct LogoutModalView: View {
    @Binding var isPresented: Bool
    var body: some View {
        VStack {
            Text("로그아웃 하시겠습니까?")
              .font(
                Font.custom("SUIT", size: 20)
                  .weight(.bold)
              )
              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
              .padding(.top,36)
            
            HStack(spacing:8) {
                Button(action: {
                    isPresented = false
                }) {
                    Text("아니요")
                        .font(Font.custom("SUIT", size: 20)
                        .weight(.semibold))
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color(red: 0.91, green: 0.91, blue: 0.93))
                        .cornerRadius(8)
                }
                Button(action: {
                    
                    isPresented = false
                }) {
                    Text("로그아웃")
                        .font(Font.custom("SUIT", size: 20)
                        .weight(.semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(Color(red: 0.15, green: 0.4, blue: 0.96))
                        .cornerRadius(8)
                }
            }
            .padding(.top,33)
            .padding(.horizontal,16)

                
            
        }
        .padding(.vertical,17)
        .frame(width: 340)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.45).opacity(0.2), radius: 3, x: 0, y: 2)
    }
}

struct SettingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingSwiftUIView()
    }
}
