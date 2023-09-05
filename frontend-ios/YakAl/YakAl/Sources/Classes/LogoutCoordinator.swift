
import Foundation
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
