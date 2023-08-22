//
//  CustomTabBar.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/23.
//

import UIKit

class CustomTabBar: UITabBar {
    var topPadding: CGFloat = 10

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height += topPadding
        return sizeThatFits
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in subviews {
            if let control = subview as? UIControl {
                control.frame = control.frame.offsetBy(dx: 0, dy: topPadding)
            }
        }
    }
}
