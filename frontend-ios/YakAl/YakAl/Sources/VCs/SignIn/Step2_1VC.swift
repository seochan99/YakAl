//
//  Step2_1VC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/27.
//

import UIKit

class Step2_1VC: SignInViewController {
    
    // 유저
    var user: User!
    
    // 아웃렛
    @IBOutlet weak var modeNormal: UIButton!
    @IBOutlet weak var modeSenior: UIButton!
    
    @IBOutlet weak var buttonHeader: UILabel!
    @IBOutlet weak var buttonContent: UILabel!
    
    @IBOutlet weak var buttonHeader2: UILabel!
    @IBOutlet weak var buttonContent2: UILabel!
    
    // 뷰 로드
    override func viewDidLoad() {
        // 노말 모드가 선택된 상태로 시작
        super.viewDidLoad()
        myStepNumber = 3
        
        // 기본 노말모드 선택 트루
        modeNormal.isSelected = true
        
        updateButtonAppearance(modeNormal, modeSenior)

    }
    
    // 선택되었을때 테두리색 변경하는 함수 만들어야함
    private func changeButtonState(_ sender:UIButton, _ otherButton : UIButton){
        let isOn = sender.isSelected
        sender.isSelected = !isOn
        updateButtonAppearance(sender, otherButton)
    }
    
    
    
    // 다음버튼 선택
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // 노인모드 선택시
        user.isSenior = modeSenior.isSelected
        
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen6VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_6") as! SignUpDoneViewController
        
        signInScreen6VC.user = user
        
        navigationController?.pushViewController(signInScreen6VC, animated: true)
    }
    
    
    
    
    // 노말 모드 선택
    @IBAction func modeNormalButtonTapped(_ sender: UIButton) {
//        changeButtonState(sender, modeSenior)
        setButtonTapped(sender, modeSenior)
    }
    
    // 라이트 모드 선택
    @IBAction func modeSeniorButtonTapped(_ sender: UIButton) {
//        changeButtonState(sender, modeNormal)
        setButtonTapped(sender, modeNormal)
    }
    
    // 버튼 상태 변경
    private func setButtonTapped(_ sender:UIButton, _ otherButton : UIButton){
        // 샌더 색상 바꾸기
        let isOn = sender.isSelected
        sender.isSelected = !isOn
        updateButtonAppearance(sender,otherButton)
    }
    
    
    // 버튼의 상태에 따라 색상 변경
    private func updateButtonAppearance(_ button: UIButton, _ otherButton: UIButton) {
        let selectedTintColor = UIColor(red: 38/255, green: 102/255, blue: 246/255, alpha: 1.0) // #2666F6
        let deselectedTintColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0) // #E9E9EE
        
        let selectedTextTintColor = UIColor(red: 38/255, green: 102/255, blue: 246/255, alpha: 1.0) // #2666F6
        let deselectedTextTintColor =  UIColor(red: 70/255, green: 70/255, blue: 85/255, alpha: 1.0) // #464655

        if button.isSelected {
            // 버튼이 선택된 경우
            setButton(button, selectedTintColor)
            setButton(otherButton, deselectedTintColor)
            // 노말모드 버튼이라면
            if(button == modeNormal){
                setText(buttonHeader, buttonContent, selectedTextTintColor)
                setText(buttonHeader2, buttonContent2, deselectedTextTintColor)
            }else{
                setText(buttonHeader2, buttonContent2, selectedTintColor)
                setText(buttonHeader, buttonContent, deselectedTextTintColor)
            }
        }
//        } else {
//            // 버튼이 선택되지 않은 경우
//            setButton(button, deselectedTintColor)
//            setButton(otherButton, deselectedTintColor)
//        }
    }
    
    // 버튼 설정
    private func setButton(_ button:UIButton, _ color:UIColor){
        // 버튼 색상 변경
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = color.cgColor
    }
    private func setText(_ text1:UILabel, _ text2:UILabel, _ color:UIColor){
        text1.textColor = color
        text2.textColor = color
    }
    
}
