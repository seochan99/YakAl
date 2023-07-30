//
//  ProfileVC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/31.
//

import UIKit
import KakaoSDKUser

enum StoryboardIdentifier: String {
    case main = "Main"
}

enum ViewControllerIdentifier: String {
    case mainVC = "MainVC" // "MainVC"는 Main 스토리보드의 ViewController의 Identity로 설정한 값입니다.
}

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
