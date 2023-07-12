//
//  MainViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit


extension UIButton {
    // 둥글게 만드는 함수
    func makeCircular() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
    }
}

//MARK: - Main UIViewController
class MainViewController: UIViewController {

    // IBOutlet 연결
    @IBOutlet weak var subTitleText: UILabel!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로그인 버튼 둥글게
        kakaoLoginButton.makeCircular()
        googleLoginButton.makeCircular()
        
        let attributedString = NSMutableAttributedString(string: "AI를 이용한 ")
           
           let boldAttributes: [NSAttributedString.Key: Any] = [
               .font: UIFont.boldSystemFont(ofSize: subTitleText.font.pointSize),
               .foregroundColor: UIColor(red: 38/255, green: 105/255, blue: 245/255, alpha: 1.0)
           ]
           
           let boldText = NSAttributedString(string: "복약도움 플랫폼", attributes: boldAttributes)

           
           attributedString.append(boldText)
           
           subTitleText.attributedText = attributedString
    }
}
