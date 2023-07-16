//
//  SignInViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit

//MARK: - 개인정보동의
class SignInViewController: UIViewController {
//
    
    @IBOutlet weak var agreeSwitch: UISwitch!
    @IBOutlet weak var agreeButton: UIButton!
    
    var bottomConstraint: NSLayoutConstraint?
    // this will be read by ProgressNavController
    //    to calculate the "progress percentage"
    public let numSteps: Int = 4
    
    // this will be set by each MyBaseVC subclass,
    //    and will be read by ProgressNavController
    public var myStepNumber: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 변화 감지
//        siginInInputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//
//        // Keyboard notifications
//         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//         // Set bottom constraint for button
//         let safeArea = self.view.safeAreaLayoutGuide
//         bottomConstraint = siginInNextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
//         bottomConstraint?.isActive = true
        
        // Set initial button state
        // IBOutlet이 올바르게 연결되었는지 확인

        
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

    
    
    
    
    // 키보드 보이게
   @objc private func keyboardWillShow(_ notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               let keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
               bottomConstraint?.constant = -(keyboardHeight+15)
               self.view.layoutIfNeeded()
           }
       }
    // 키보드 가리기
       @objc private func keyboardWillHide(_ notification: NSNotification) {
           bottomConstraint?.constant = 0
           self.view.layoutIfNeeded()
       }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        setAgreeButtonState(agreeButton, isOn: sender.isOn)
    }
    
    
    @IBAction func agreeButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen3VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_3") as! Step1VC
        navigationController?.pushViewController(signInScreen3VC, animated: true)
    }
    
}



//MARK: - 본인이름
class Step1VC: SignInViewController {
    
    @IBOutlet weak var siginInInputField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 1
        
        // maybe some other stuff specific to this "step"
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}


//MARK: - 생년월일
class Step2VC: SignInViewController {
    @IBOutlet weak var birthPicker: UIDatePicker!
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 2
        
        // maybe some other stuff specific to this "step"
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
}

//MARK: - 전화번호 입력
class Step3VC: SignInViewController {
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 3
        
        // maybe some other stuff specific to this "step"
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
    }
    
}
//MARK: - 문자인증
class Step4VC: SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 4
        
        // maybe some other stuff specific to this "step"
    }
    
}

