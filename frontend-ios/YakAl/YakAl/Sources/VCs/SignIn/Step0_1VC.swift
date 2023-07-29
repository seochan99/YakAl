//
//  Step0-1VC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/25.
//

import UIKit

class Step0_1VC: SignInViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    // Add 'user' property
     var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 1
        // Do any additional setup after loading the view.
    }
    
    // 버튼이 눌러졌을때 다음 화면으로
    
    @IBAction func agreeButtonTapped2(_ sender: UIButton) {
   
        // 본인 인증 성공
        user.isVerify = true
        // 스토리 보드 이동
        
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen3VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_4") as! Step1VC
        signInScreen3VC.user = User.shared
        

//        performSegue(withIdentifier: "ShowMain", sender: sender)
        
        navigationController?.pushViewController(signInScreen3VC, animated: true)
    }
    
    // 본인 인증 스킵
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen3VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_4") as! Step1VC
        signInScreen3VC.user = User.shared
        

//        performSegue(withIdentifier: "ShowMain", sender: sender)
        
        navigationController?.pushViewController(signInScreen3VC, animated: true)
    }
    
    
}
