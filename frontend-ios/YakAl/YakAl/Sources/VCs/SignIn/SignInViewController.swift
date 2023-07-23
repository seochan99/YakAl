//
//  SignInViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit
import DropDown

//MARK: - 개인정보동의
class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var agreeSwitch: UISwitch!
    @IBOutlet weak var agreeButton: UIButton!
    
    
    @IBOutlet weak var overallCheckbox: UIButton!
    @IBOutlet weak var serviceTermsCheckbox1: UIButton!
    @IBOutlet weak var serviceTermsCheckbox2: UIButton!
    @IBOutlet weak var serviceTermsCheckbox3: UIButton!
    @IBOutlet weak var marketingCheckbox: UIButton!
    
    public let numSteps: Int = 4
    public var myStepNumber: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = " " // 원하는 타이틀을 설정
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial button state
        // IBOutlet이 올바르게 연결되었는지 확인

        self.navigationItem.title=" "
        
        // Set initial button state
        if let agreeSwitch = agreeSwitch {
            setAgreeButtonState(agreeButton, isOn: agreeSwitch.isOn)
        }
    }
    
    // 개인정보 동의 여부 확인
    private func setAgreeButtonState(_ button: UIButton, isOn: Bool) {
        if isOn {
            button.isEnabled = true
            button.backgroundColor = UIColor(red: 38/255, green: 102/255, blue: 246/255, alpha: 1.0)
            button.setTitleColor(.white, for: .normal)
        } else {
            button.isEnabled = false
            button.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0)
            button.setTitleColor(UIColor(red: 198/255, green: 198/255, blue: 207/255, alpha: 1.0), for: .disabled)
        }
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        setAgreeButtonState(agreeButton, isOn: sender.isOn)
    }
    
    
    @IBAction func agreeButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen3VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_3") as! Step1VC
        
        signInScreen3VC.user = User.shared

        navigationController?.pushViewController(signInScreen3VC, animated: true)
    }
}




