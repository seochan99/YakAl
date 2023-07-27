//
//  Step2_1VC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/27.
//

import UIKit

class Step2_1VC: UIViewController {
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
//        user.step1Input = siginInInputField.text!
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen6VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_6") as! SignUpDoneViewController
        
        signInScreen6VC.user = user
        
        navigationController?.pushViewController(signInScreen6VC, animated: true)
    }
}
