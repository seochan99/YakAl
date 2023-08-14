import UIKit

class ExpandableTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(title: String, description: String, isExpanded: Bool) {
        titleLabel.text = title
        descriptionLabel.text = description
        descriptionLabel.isHidden = !isExpanded
    }
}
