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
    // 다음 버튼
    @IBOutlet weak var agreeButton: UIButton!
    
    // 체크 박스
    @IBOutlet weak var overallCheckbox: UIButton!
    @IBOutlet weak var serviceTermsCheckbox1: UIButton!
    @IBOutlet weak var serviceTermsCheckbox2: UIButton!
    @IBOutlet weak var serviceTermsCheckbox3: UIButton!
    @IBOutlet weak var marketingCheckbox: UIButton!
    // 총 스텝
    public let numSteps: Int = 4
    public var myStepNumber: Int = 0
    
    // 보이기 이전에
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = " " // 원하는 타이틀을 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial button state
        // IBOutlet이 올바르게 연결되었는지 확인

        self.navigationItem.title=" "
        changeNaviBack()
    }
  
    // 전체 승인 버튼
    @IBAction func AllAproveButtonOn(_ sender: UIButton) {
        
        let allButtons = [overallCheckbox, serviceTermsCheckbox1, serviceTermsCheckbox2, serviceTermsCheckbox3, marketingCheckbox]
        
        // 전체 동의 버튼의 상태에 따라 모든 버튼을 On 또는 Off로 설정
        let isAllOn = overallCheckbox.isSelected
        // 전체 동의 버튼의 상태를 toggle (ON이면 OFF로, OFF면 ON으로 변경)
        overallCheckbox.isSelected = !isAllOn
        
        // 모든 버튼 반복문 돌면서 상태 변경
        for button in allButtons {
            button?.isSelected = !isAllOn
            updateButtonAppearance(button ?? serviceTermsCheckbox1)
        }
        
        // setAgreeButtonState 함수 호출하여 버튼 상태 업데이트
        setAgreeButtonState(agreeButton, isOn: !isAllOn)
            
        
    }
    
    // 필수 동의 버튼을 눌렀을 때
    @IBAction func serviceTermsCheckboxTapped(_ sender: UIButton) {
        
        // 버튼 상태 변경
        changeButtonState(sender)
        
        // 필수 버튼이 선택되어 있다면 다음 버튼 활성화
        setAgreeButtonState(agreeButton, isOn: essentialButtonAllChecked())
        
        // 세 버튼 모두 선택되어 있을시 전체 동의 버튼 상태 업데이트
        updateOverallCheckboxState()

    }

    
    // 선택 동의 버튼을 눌렀을 때
    @IBAction func marketingCheckboxTapped(_ sender: UIButton) {
        
        // 버튼 상태 업데이트
        changeButtonState(sender)

        // 모든 버튼이 선택되어 있다면 전체 동의 버튼 활성화
        updateOverallCheckboxState()
    }
    
    private func updateOverallCheckboxState() {
        if areAllServiceTermsChecked() {
            overallCheckbox.isSelected = true
            updateButtonAppearance(overallCheckbox)
        } else {
            overallCheckbox.isSelected = false
            updateButtonAppearance(overallCheckbox)
        }
    }
    // 버튼 상태 변경
    private func changeButtonState(_ sender:UIButton){
        let isOn = sender.isSelected
        sender.isSelected = !isOn
        updateButtonAppearance(sender)
    }
    
    // 필수&선택 동의 버튼들이 모두 선택되었는지 확인
    private func areAllServiceTermsChecked() -> Bool {
        return serviceTermsCheckbox1.isSelected && serviceTermsCheckbox2.isSelected && serviceTermsCheckbox3.isSelected && marketingCheckbox.isSelected
    }
    
    // 필수 동의 버튼들이 모두 선택되었는지 확인
    private func essentialButtonAllChecked() -> Bool {
        return serviceTermsCheckbox1.isSelected && serviceTermsCheckbox2.isSelected && serviceTermsCheckbox3.isSelected
    }
    
    // 버튼의 상태에 따라 색상 변경
    private func updateButtonAppearance(_ button: UIButton) {
        let selectedTintColor = UIColor(red: 38/255, green: 102/255, blue: 246/255, alpha: 1.0) // #2666F6
        let deselectedTintColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0) // #E9E9EE
        
        if button.isSelected {
            // 이미지 선택 상태에 맞게 tint 색상 변경
            button.imageView?.tintColor = selectedTintColor
            button.setTitleColor(.white, for: .normal)
        } else {
            // 이미지 비선택 상태에 맞게 tint 색상 변경
            button.imageView?.tintColor = deselectedTintColor
            button.setTitleColor(UIColor(red: 198/255, green: 198/255, blue: 207/255, alpha: 1.0), for: .normal)
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
    
    // 버튼이 눌러졌을때 다음 화면으로
    @IBAction func agreeButtonTapped(_ sender: UIButton) {
        
        
        
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen3VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_3") as! Step0_1VC
        signInScreen3VC.user = User.shared
        

//        performSegue(withIdentifier: "ShowMain", sender: sender)
        
        navigationController?.pushViewController(signInScreen3VC, animated: true)
    }
}





