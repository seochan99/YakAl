//
//  EmptyGroupTableViewCell.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/31.
//

import UIKit

class EmptyGroupTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: Const.Xib.EmptyGroupTableViewCell, bundle: Bundle(for: EmptyGroupTableViewCell.self))
    }
}
