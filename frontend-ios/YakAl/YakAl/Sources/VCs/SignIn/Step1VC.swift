//
//  Step1VC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/23.
//

import UIKit

//MARK: - 본인이름
class Step1VC: SignInViewController {
    
    @IBOutlet weak var siginInInputField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var headerTextLabel: UILabel!
    // Add 'user' property
     var user: User!
     
    
    var bottomConstraint: NSLayoutConstraint?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = " " // 원하는 타이틀을 설정
    }
    override func viewDidLoad() {
        self.navigationController?.navigationBar.topItem?.title = "약관 동의"


           super.viewDidLoad()
           myStepNumber = 1
        
        let text = headerTextLabel.text ?? ""
        let attributedText = NSMutableAttributedString(string: text)

        let boldFont = UIFont.boldSystemFont(ofSize: headerTextLabel.font.pointSize)
        let mediumFont = UIFont.systemFont(ofSize: headerTextLabel.font.pointSize, weight: .medium)

        let boldRange = (text as NSString).range(of: "이름")
        let mediumRange = NSRange(location: 0, length: text.count)

        attributedText.addAttribute(.font, value: mediumFont, range: mediumRange)
        attributedText.addAttribute(.font, value: boldFont, range: boldRange)

        headerTextLabel.attributedText = attributedText



           
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
       
       
       @IBAction func nextButtonTapped(_ sender: UIButton) {
           print("이전 \(user.step1Input)")
           user.step1Input = siginInInputField.text!
           print("이후 \(user.step1Input)")
           print("이후 \(user)")
           
           let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
           let signInScreen4VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_4") as! Step2VC
           
           signInScreen4VC.user = user
           
           navigationController?.pushViewController(signInScreen4VC, animated: true)
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
           if let text = siginInInputField.text, !text.isEmpty {
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
