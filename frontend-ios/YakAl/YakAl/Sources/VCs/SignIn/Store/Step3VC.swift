//
//  Step3V.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/23.
//

import UIKit
import DropDown
//MARK: - 전화번호 입력
class Step3VC: SignInViewController,UITextFieldDelegate
{
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var siginInInputField: UITextField!
    
    var bottomConstraint: NSLayoutConstraint?
    // Add 'user' property
     var user: User!
     
    // dropdown 객체 생성
    let dropdown = DropDown()
    
    // DropDown 아이템 리스트
    let itemList = ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = " " // 원하는 타이틀을 설정
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 3
        self.navigationController?.navigationBar.topItem?.title = "생년월일"
        
        // UI 초기화
        initUI();
        setDropdown();
        // maybe some other stuff specific to this "step"
        siginInInputField.delegate = self

        
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
          if newLength > 11 {
              return false
          }

          return true
      }

    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if let phoneNumber = siginInInputField.text {
//               let numericPhoneNumber = formatPhoneNumber(phoneNumber)
//               user.step3Input = numericPhoneNumber
           }

        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen6VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_6") as! Step4VC
        
        signInScreen6VC.user = user
        
        navigationController?.pushViewController(signInScreen6VC, animated: true)
    }
    
    // DropDown UI 커스텀
    func initUI() {
        // DropDown View의 배경
        dropView.layer.borderWidth = 1.0
        dropView.layer.borderColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0).cgColor

        dropView.layer.cornerRadius = 8
        
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        
        DropDown.appearance().selectedTextColor = UIColor.white // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropdown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        tfInput.isUserInteractionEnabled = false
        ivIcon.tintColor = UIColor.gray
        
    }
    
    func setDropdown() {
        // dataSource로 ItemList를 연결
        dropdown.dataSource = itemList
        


        
        // anchorView를 통해 UI와 연결
        dropdown.anchorView = self.dropView
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropdown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        // Item 선택 시 처리
        dropdown.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self!.tfInput.text = item
            self!.ivIcon.image = UIImage.init(systemName: "chevron.down")
            
            self?.updateNextButtonState()
        }
        tfInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        // 취소 시 처리
        dropdown.cancelAction = { [weak self] in
            //빈 화면 터치 시 DropDown이 사라지고 아이콘을 원래대로 변경
            self?.ivIcon.image = UIImage(systemName: "chevron.down")

        }
    }
    // View 클릭 시 Action
    @IBAction func dropdownClicked(_ sender: Any) {
        dropdown.show() // 아이템 팝업을 보여준다.
        
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
        if dropdown.isHidden {
            ivIcon.image = UIImage(systemName: "chevron.down")
        } else {
            ivIcon.image = UIImage(systemName: "chevron.up")
        }
    }
    
    // Handle text field editing changed event
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            siginInInputField.layer.borderWidth = 2.0
            siginInInputField.layer.cornerRadius = 8
            siginInInputField.layer.borderColor = UIColor(red: 85/255, green: 136/255, blue: 253/255, alpha: 1.0).cgColor
        }
//        else {
//           // siginInInputField.layer.borderWidth = 2.0
//           // siginInInputField.layer.cornerRadius = 8
//           // siginInInputField.layer.borderColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0).cgColor
//       }
        
        updateNextButtonState()
    }
       
       // Update the state of the nextButton based on the text field's content
       private func updateNextButtonState() {
           if let text = siginInInputField.text, !text.isEmpty, text.count==11, let inputText = tfInput.text, !inputText.isEmpty {
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
    
    private func formatPhoneNumber(_ phoneNumber: String) -> String {
        let numericPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return numericPhoneNumber
    }
}
