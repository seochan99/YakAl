//
//  TodoTableViewCell.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/31.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var mealTimeLabel: UILabel!
    @IBOutlet weak var medicationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Method to configure the cell with the provided TodoItem
      func configure(with todoItem: TodoItem) {
          mealTimeLabel.text = todoItem.mealTime.rawValue
          medicationLabel.text = todoItem.medication.joined(separator: ", ")
      }
    
}
