//
//  SignUpDoneViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/27.
//

import UIKit

class SignUpDoneViewController: UIViewController {
    var user: User!
    
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let nickname = user?.nickName {
            let attributedText = NSMutableAttributedString(string: nickname)
            attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: nickname.count))
            name.attributedText = attributedText
        }
        // Do any additional setup after loading the view.
    }
    

}
