//
//  SignInViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var siginInInputField: UITextField!
//
    var bottomConstraint: NSLayoutConstraint?
    var currentStep: Int = 0
    
    // this will be read by ProgressNavController
    //    to calculate the "progress percentage"
    public let numSteps: Int = 3
    
    // this will be set by each MyBaseVC subclass,
    //    and will be read by ProgressNavController
    public var myStepNumber: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 둥글게 만들기
//        siginInNextButton.makeCircular()
        
        // 비활성화
//        siginInNextButton.isEnabled = false
//        siginInNextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0)
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
//
//        // Update initial progress
//         updateProgress()
    }
    
    
    
//    // 키보드 보이게
//   @objc private func keyboardWillShow(_ notification: NSNotification) {
//       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//               let keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
//               bottomConstraint?.constant = -(keyboardHeight+15)
//               self.view.layoutIfNeeded()
//           }
//       }
//    // 키보드 가리기
//       @objc private func keyboardWillHide(_ notification: NSNotification) {
//           bottomConstraint?.constant = 0
//           self.view.layoutIfNeeded()
//       }
//
//
    
    
    
    // 텍스트 필드 바뀔때
//    @objc private func textFieldDidChange(_ textField: UITextField) {
//        siginInNextButton.isEnabled = !(textField.text?.isEmpty ?? false)!
//
//        if siginInNextButton.isEnabled {
//            siginInNextButton.backgroundColor = UIColor.blue // 활성화 색상 설정
//        } else {
//            siginInNextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0) // 비활성화 색상 설정
//        }
//    }
    
//    @IBAction func nextButtonTapped(_ sender: UIButton) {
//        // Move to the next step
//        currentStep += 1
//        
//        // Update progress
//        updateProgress()
//        
//        // Reset input field and enable next button
//        siginInInputField.text = ""
//        siginInNextButton.isEnabled = false
//        siginInNextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0)
//        
//        // Update header and title text
//        siginInHeaderText.text = signUpData[currentStep].headerText
//        siginInTitleText.text = signUpData[currentStep].titleText
//        siginInInputField.placeholder = signUpData[currentStep].placeholder
//    }
//    
//    private func updateProgress() {
//        let progress = Float(currentStep) / Float(signUpData.count - 1)
//        signInProgressBar.setProgress(progress, animated: true)
//    }
    
}
class Step1VC: SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 1
        
        // maybe some other stuff specific to this "step"
    }
    
}
class Step2VC: SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 2
        
        // maybe some other stuff specific to this "step"
    }
    
}
class Step3VC: SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 3
        
        // maybe some other stuff specific to this "step"
    }
    
}
class Step4VC: SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 4
        
        // maybe some other stuff specific to this "step"
    }
    
}

