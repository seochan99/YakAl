//
//  MainViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit


extension UIButton {
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
    }
}
