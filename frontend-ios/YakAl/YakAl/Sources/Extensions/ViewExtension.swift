import SwiftUI

// 뷰 익스텐션
extension View {
    // 바 숨기기
    func hideTabBar() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController {
            tabBarController.tabBar.isHidden = true
        }
    }
    // 바 보이게
    func showTabBar() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let tabBarController = windowScene.windows.first?.rootViewController as? UITabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
}
