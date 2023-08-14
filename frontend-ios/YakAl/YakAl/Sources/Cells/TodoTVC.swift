import UIKit

class TodoTVC: UITableViewCell {
    @IBOutlet weak var allDoneButton: UIButton!
    @IBOutlet weak var todoIcon: UIImageView!
    @IBOutlet weak var todoTimeLabel: UILabel!
    @IBOutlet weak var todoCnt: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // 셀의 선택 상태가 변경될 때 호출되는 메서드
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // 데이터를 설정하는 메서드
    func configure(with todoItem: TodoItem) {
        // 예시로 todoTimeLabel에 복용 시간을 설정해보겠습니다.
        todoTimeLabel.text = todoItem.mealTime.rawValue
        // todoCnt에 약물 개수를 설정합니다.
        let medicationCount = todoItem.medication.count
        todoCnt.text = "\(medicationCount)개"
    }
}
