//
//  SignInViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var siginInHeaderText: UILabel!
    @IBOutlet weak var siginInInputField: UITextField!
    @IBOutlet weak var signInProgressBar: UIProgressView!
    @IBOutlet weak var siginInTitleText: UILabel!
    @IBOutlet weak var siginInNextButton: UIButton!
    
    var bottomConstraint: NSLayoutConstraint?
    var currentStep: Int = 0
    
    let signUpData: [SignUpModel] = [
        SignUpModel(headerText: "본인확인을 위한 이름을 입력해주세요", titleText: "이름", placeholder: "실제 이름을 입력해주세요 (예. 홍길동)"),
        SignUpModel(headerText: "주민등록번호 앞 7자리를\n 입력해주세요", titleText: "주민등록번호", placeholder: "000000 - 0 · · · · ·"),
        SignUpModel(headerText: "전화번호를 입력해주세요", titleText: "전화번호", placeholder: "010-0000-0000")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 둥글게 만들기
        siginInNextButton.makeCircular()
        
        // 비활성화
        siginInNextButton.isEnabled = false
        siginInNextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0)
        // 변화 감지
        siginInInputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Keyboard notifications
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         
         // Set bottom constraint for button
         let safeArea = self.view.safeAreaLayoutGuide
         bottomConstraint = siginInNextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
         bottomConstraint?.isActive = true
        
        // Update initial progress
         updateProgress()
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
       
    
    // 텍스트 필드 바뀔때
    @objc private func textFieldDidChange(_ textField: UITextField) {
        siginInNextButton.isEnabled = !(textField.text?.isEmpty ?? false)!
        
        if siginInNextButton.isEnabled {
            siginInNextButton.backgroundColor = UIColor.blue // 활성화 색상 설정
        } else {
            siginInNextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0) // 비활성화 색상 설정
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Move to the next step
        currentStep += 1
        
        // Update progress
        updateProgress()
        
        // Reset input field and enable next button
        siginInInputField.text = ""
        siginInNextButton.isEnabled = false
        siginInNextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0)
        
        // Update header and title text
        siginInHeaderText.text = signUpData[currentStep].headerText
        siginInTitleText.text = signUpData[currentStep].titleText
        siginInInputField.placeholder = signUpData[currentStep].placeholder
    }
    
    private func updateProgress() {
        let progress = Float(currentStep) / Float(signUpData.count - 1)
        signInProgressBar.setProgress(progress, animated: true)
    }
    
}
