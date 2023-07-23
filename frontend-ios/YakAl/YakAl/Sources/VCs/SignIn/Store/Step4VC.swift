//
//  Step4VC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/23.
//

import UIKit

//MARK: - 문자인증
class Step4VC: SignInViewController,UITextFieldDelegate {
    
    @IBOutlet weak var siginInInputField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    // Add 'user' property
     var user: User!
     
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = " " // 원하는 타이틀을 설정
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 4
        self.navigationController?.navigationBar.topItem?.title = "전화번호"
        siginInInputField.delegate = self

        // maybe some other stuff specific to this "step"
        // Set bottom constraint for button
        let safeArea = self.view.safeAreaLayoutGuide
        bottomConstraint = nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
        bottomConstraint?.isActive = true
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Add target for text field's editing changed event
        siginInInputField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // Set initial state of the nextButton
        updateNextButtonState()
    }
    
    // Implement UITextFieldDelegate method
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          // Check if the input is a number
          let numberCharacterSet = CharacterSet(charactersIn: "0123456789")
          let stringCharacterSet = CharacterSet(charactersIn: string)
          if !stringCharacterSet.isSubset(of: numberCharacterSet) {
              return false
          }

          // Calculate the new length of the text after replacement
          guard let text = textField.text else {
              return true
          }
          let newLength = text.count + string.count - range.length

          // Check if the new length exceeds the maximum length (6)
          if newLength > 6 {
              return false
          }

          return true
      }

    
    
    @IBAction func goMainButton(_ sender: UIButton) {
        user.step4Input = siginInInputField.text!
        print(user!)

        let storyboard = UIStoryboard(name: "Home", bundle: nil)
           let homeScreen1VC = storyboard.instantiateViewController(withIdentifier: "HomeScreen_1")
           navigationController?.setNavigationBarHidden(true, animated: false)
           navigationController?.pushViewController(homeScreen1VC, animated: true)
    }
    
    
    
    
    // Handle text field editing changed event
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            siginInInputField.layer.borderWidth = 2.0
            siginInInputField.layer.cornerRadius = 8
            siginInInputField.layer.borderColor = UIColor(red: 85/255, green: 136/255, blue: 253/255, alpha: 1.0).cgColor
        } else {
//            siginInInputField.layer.borderWidth = 2.0
//            siginInInputField.layer.cornerRadius = 8
//            siginInInputField.layer.borderColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0).cgColor
        }
        updateNextButtonState()
    }
       
       // Update the state of the nextButton based on the text field's content
       private func updateNextButtonState() {
           if let text = siginInInputField.text, text.count == 6 {
               nextButton.isEnabled = true
               nextButton.backgroundColor = UIColor(red: 38/255, green: 102/255, blue: 246/255, alpha: 1.0)
               nextButton.setTitleColor(.white, for: .normal)
           } else {
               nextButton.isEnabled = false
               nextButton.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0)
               nextButton.setTitleColor(UIColor(red: 198/255, green: 198/255, blue: 207/255, alpha: 1.0), for: .disabled)
           }
       }
       
       // Show the keyboard
       @objc private func keyboardWillShow(_ notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               let keyboardHeight = keyboardSize.height - self.view.safeAreaInsets.bottom
               bottomConstraint?.constant = -(keyboardHeight + 15)
               self.view.layoutIfNeeded()
           }
       }
       
       // Hide the keyboard
       @objc private func keyboardWillHide(_ notification: NSNotification) {
           bottomConstraint?.constant = 0
           self.view.layoutIfNeeded()
       }
}
