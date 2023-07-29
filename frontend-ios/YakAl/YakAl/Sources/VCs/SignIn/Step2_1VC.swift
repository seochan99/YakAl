//
//  Step2_1VC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/27.
//

import UIKit

class Step2_1VC: SignInViewController {
    var user: User!
    
    
    @IBOutlet weak var modeNormal: UIButton!
    @IBOutlet weak var modeSenior: UIButton!
    
    
    override func viewDidLoad() {
        // 노말 모드가 선택된 상태로 시작
        super.viewDidLoad()
        updateButtonAppearance(modeNormal, modeSenior)
        myStepNumber = 3
        
        
    }
    
    
    // 선택되었을때 테두리색 변경하는 함수 만들어야함
    

    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // 노인모드 선택시
        user.isSenior = modeSenior.isSelected
        
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen6VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_6") as! SignUpDoneViewController
        
        signInScreen6VC.user = user
        
        navigationController?.pushViewController(signInScreen6VC, animated: true)
    }
    @IBAction func modeNormalButtonTapped(_ sender: UIButton) {
        setButtonTapped(sender, modeSenior)
    }
    
    @IBAction func modeSeniorButtonTapped(_ sender: UIButton) {
        setButtonTapped(sender, modeNormal)
    }
    
    // 버튼 상태 변경
    private func setButtonTapped(_ sender:UIButton, _ otherButton : UIButton){
        // 샌더와 다른 타입의 색상 없애기
        
        // 샌더 색상 바꾸기
        let isOn = sender.isSelected
        sender.isSelected = isOn
        
        
        updateButtonAppearance(sender,otherButton)
    }
    
    // 버튼의 상태에 따라 색상 변경
    private func updateButtonAppearance(_ button: UIButton, _ otherButton : UIButton) {
        let selectedTintColor = UIColor(red: 38/255, green: 102/255, blue: 246/255, alpha: 1.0) // #2666F6
        let deselectedTintColor = UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1.0) // #E9E9EE
        
        if button.isSelected {
            // 이미지 선택 상태에 맞게 tint 색상 변경
            setButton(button,selectedTintColor)
            setButton(otherButton,deselectedTintColor)
            
        }
    }
    private func setButton(_ button:UIButton, _ color:UIColor){
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = color.cgColor
    }
}
