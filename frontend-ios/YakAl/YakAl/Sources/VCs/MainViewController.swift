//
//  MainViewController.swift
//  YakAl
//
//

import KakaoSDKUser

import UIKit


extension UIButton {
    // 둥글게 만드는 함수
    func makeCircular() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
    }
}

//MARK: - Main UIViewController
class MainViewController: UIViewController {
    
    // 회원가입 여부
    var isSignedUp: Bool = false


    // IBOutlet 연결
    @IBOutlet weak var subTitleText: UILabel!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로그인 버튼 둥글게
        kakaoLoginButton.makeCircular()
        appleLoginButton.makeCircular()
        
        let attributedString = NSMutableAttributedString(string: "AI를 이용한 ")
           
           let boldAttributes: [NSAttributedString.Key: Any] = [
               .font: UIFont.boldSystemFont(ofSize: subTitleText.font.pointSize),
               .foregroundColor: UIColor(red: 38/255, green: 105/255, blue: 245/255, alpha: 1.0)
           ]
           
           let boldText = NSAttributedString(string: "복약도움 플랫폼", attributes: boldAttributes)

           
           attributedString.append(boldText)
           
           subTitleText.attributedText = attributedString
    }
    
    // 로그인 버튼 클릭 시 처리
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                
                    print(oauthToken)
                    
                    // 만약 oauthToken으로 jwt가 있다면, 로그인으로
                    
                    // 만약 처음온 상태라면 회원가입으로
                    // isSignedUp이 true라면 Home으로
                    let storyboardName = self.isSignedUp ? "Home" : "SignIn"
                    
                    
                    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                    if let initialViewController = storyboard.instantiateViewController(withIdentifier: self.isSignedUp ? "HomeScreen_1" : "SignInScreen_1") as? UIViewController {
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                            sceneDelegate.window?.rootViewController = initialViewController
                        }
                    }
                    
                }
            }
        }
        
        
      
    }
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        
        
        
        
        // 만약 처음온 상태라면 회원가입으로
        // isSignedUp이 true라면 Home으로
        let storyboardName = isSignedUp ? "Home" : "SignIn"
        
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let initialViewController = storyboard.instantiateViewController(withIdentifier: isSignedUp ? "HomeScreen_1" : "SignInScreen_1") as? UIViewController {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = initialViewController
            }
        }
        
    }
    
    
}
