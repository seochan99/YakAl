import UIKit
import KakaoSDKUser
import SwiftUI

enum StoryboardIdentifier: String {
    case main = "Main"
}

enum ViewControllerIdentifier: String {
    case mainVC = "MainVC" // "MainVC"는 Main 스토리보드의 ViewController의 Identity로 설정한 값입니다.
}

class ProfileVC: UIViewController {
    var profileHostingController: UIHostingController<MypageSwiftUIView>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let profileSwiftUIView = MypageSwiftUIView()
        
        let profileHostingController = UIHostingController(rootView: profileSwiftUIView)
        addChild(profileHostingController)
        profileHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        // Add CalendarSwiftUIView to the main view
        view.addSubview(profileHostingController.view)
        NSLayoutConstraint.activate([
            profileHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            profileHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        profileHostingController.didMove(toParent: self)
    }
    
    @IBAction func logout(_ sender: UIButton) {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                // 로그아웃 성공 시, UserDefaults에서 KakaoAccessToken 삭제
                UserDefaults.standard.removeObject(forKey: "KakaoAccessToken")
                print("logout() success.")
                
                // 로그인 페이지로 이동
                if let window = UIApplication.shared.keyWindow {
                               let storyboard = UIStoryboard(name: StoryboardIdentifier.main.rawValue, bundle: nil)
                               if let mainVC = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifier.mainVC.rawValue) as? UIViewController {
                                   window.rootViewController = mainVC
                               }
                           }
            }
        }
    }

}
