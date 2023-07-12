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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        siginInNextButton.makeCircular()
        
        siginInNextButton.isEnabled = false
           siginInNextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0)
           
           siginInInputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // 키보드 올라옴/내려감 이벤트를 감지하기 위한 옵저버 등록
        // Keyboard notifications
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         
         // Set bottom constraint for button
         let safeArea = self.view.safeAreaLayoutGuide
         bottomConstraint = siginInNextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
         bottomConstraint?.isActive = true
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
    
}
