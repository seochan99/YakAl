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
    
    // this will be read by ProgressNavController
    //    to calculate the "progress percentage"
    public let numSteps: Int = 4
    
    // this will be set by each MyBaseVC subclass,
    //    and will be read by ProgressNavController
    public var myStepNumber: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
          super.viewDidLoad()
          myStepNumber = 1
          
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
          let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
          let signInScreen4VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_4") as! Step2VC
          navigationController?.pushViewController(signInScreen4VC, animated: true)
      }
      
    // Handle text field editing changed event
     @objc private func textFieldDidChange(_ textField: UITextField) {
         updateNextButtonState()
     }
    
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
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen5VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_5") as! Step3VC
        navigationController?.pushViewController(signInScreen5VC, animated: true)
    }
}

//MARK: - 전화번호 입력
class Step3VC: SignInViewController
{
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    
    var bottomConstraint: NSLayoutConstraint?
    
    // dropdown 객체 생성
    let dropdown = DropDown()
    
    // DropDown 아이템 리스트
    let itemList = ["SKT", "KT", "LG U+", "SKT 알뜰폰", "KT 알뜰폰", "LG U+ 알뜰폰"]
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        myStepNumber = 3
        
        // UI 초기화
        initUI();
        setDropdown();
        // maybe some other stuff specific to this "step"
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen6VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_6") as! Step4VC
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
        }
        
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

}
//MARK: - 문자인증
class Step4VC: SignInViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStepNumber = 4
        
        // maybe some other stuff specific to this "step"
    }
    
    @IBAction func goMainButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
           let homeScreen1VC = storyboard.instantiateViewController(withIdentifier: "HomeScreen_1")
           navigationController?.setNavigationBarHidden(true, animated: false)
           navigationController?.pushViewController(homeScreen1VC, animated: true)
    }
}

