//
//  MainViewController.swift
//  YakAl
//
//

import KakaoSDKUser
import AuthenticationServices
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        // accessToken이 있다면 자동 로그인 처리
        if let accessToken = UserDefaults.standard.string(forKey: "KakaoAccessToken") {
            // 이미 로그인한 사용자의 액세스 토큰이 있다면, 이를 사용하여 자동 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("카카오톡 자동 로그인 실패: \(error)")
                } else {
                    // 로그인 성공 시 처리
                    // 이후에 필요한 작업 수행
                    self.isSignedUp = true
                    self.goNextScreen()
                }
            }
        }
    }
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
                    _ = oauthToken
                
                    // 토큰 기기에 저장학
                    if let token = oauthToken?.accessToken {
                        // 액세스 토큰 저장 및 사용자 로그인 상태 유지
                        UserDefaults.standard.set(token, forKey: "KakaoAccessToken")
                    }
                    
                    // 만약 oauthToken으로 jwt가 있다면, 로그인으로
                    
                    // 만약 처음온 상태라면 회원가입으로
                    // isSignedUp이 true라면 Home으로

                    self.goNextScreen()
                }
            }
        }
    }
    
    private func goNextScreen(){
        let storyboardName = self.isSignedUp ? "Home" : "SignIn"
        
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let initialViewController = storyboard.instantiateViewController(withIdentifier: self.isSignedUp ? "HomeScreen_1" : "SignInScreen_1") as? UIViewController {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = initialViewController
            }
        }
    }
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email] //유저로 부터 알 수 있는 정보들(name, email)
               
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension MainViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //로그인 성공
        
        
        
        // 만약 처음온 상태라면 회원가입으로
        // isSignedUp이 true라면 Home으로
        let storyboardName = isSignedUp ? "Home" : "SignIn"
        
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let initialViewController = storyboard.instantiateViewController(withIdentifier: isSignedUp ? "HomeScreen_1" : "SignInScreen_1") as? UIViewController {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = initialViewController
            }
        }
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // You can create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("identifyTokenString: \(identifyTokenString)")
            }
            
            print("useridentifier: \(userIdentifier)")
            print("fullName: \(String(describing: fullName))")
            print("email: \(email)")
            
            //Move to MainPage
            //let validVC = SignValidViewController()
            //validVC.modalPresentationStyle = .fullScreen
            //present(validVC, animated: true, completion: nil)
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 로그인 실패(유저의 취소도 포함)
        print("login failed - \(error.localizedDescription)")
    }
}
