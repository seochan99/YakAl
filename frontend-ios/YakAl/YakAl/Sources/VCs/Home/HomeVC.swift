//
//  HomeViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var floatingStackView: UIStackView!
    
    @IBOutlet weak var myTodoTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var addModalView: UIView!
    @IBOutlet weak var AddModalButtonView: UIView!
    
//    버튼
    @IBOutlet weak var EnvelopeMedicineButton: UIButton!
    @IBOutlet weak var normalMedicineButton: UIButton!
    @IBOutlet weak var DirectMedicineButton: UIButton!
    
    @IBOutlet weak var addMedicineButton: UIButton!
    
    
    // 버튼들이 들어있는 모달 뷰
    lazy var buttons: [UIView] = [self.addModalView]

    // 플로팅 버튼 상태에 대한 플래그
    var isShowFloating: Bool = false


    // 배경 어둡게 만드는 view
    lazy var floatingDimView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - (self.tabBarController?.tabBar.frame.height ?? 0)))

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        view.alpha = 0
        view.isHidden = true

        self.view.insertSubview(view, belowSubview: self.floatingStackView)

        return view
    }()
    
    // 이곳에 해당하는 데이터 배열이 있을 것으로 가정합니다.
     var myTodoItems: [TodoItem] = [] // TodoItem은 Todo 아이템 데이터 모델로 가정합니다.
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Todo 아이템의 개수를 반환합니다.
        return myTodoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoTableViewCell
        
        // 현재 indexPath에 해당하는 Todo 아이템을 가져옵니다.
        let todoItem = myTodoItems[indexPath.row]
        
        // TodoTableViewCell에 약물 정보를 설정합니다.
        cell.configure(with: todoItem)
        
        return cell
    }
    
    // UIColor 객체를 #E9E9EE 색상으로 생성
    let borderColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    

    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calendarView의 레이어(border)의 색상을 설정
        calendarView.layer.borderColor = borderColor.cgColor
        addModalView.layer.borderColor = borderColor.cgColor
      
    }
    
    // 아래 메서드를 사용하여 emptyView의 상태를 갱신합니다.
    func updateEmptyViewVisibility() {
        if myTodoItems.count == 0 {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
    
    
  
    @IBAction func EnvelopeMedicineButtonAction(_ sender: UIButton) {
        print("EnvelopeMedicineButtonAction")
    }
    @IBAction func normalMedicineButtonAction(_ sender: UIButton) {
        print("normalMedicineButtonAction")
    }
    @IBAction func DirectMedicineButtonAction(_ sender: UIButton) {
        print("DirectMedicineButtonAction")
    }
    
    
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        print("약 추가 버튼 선택됨")
        
        
        if isShowFloating {
            // 약 추가 목록버튼모달 없애기
            UIView.animate(withDuration: 0.3, animations: {
                self.floatingDimView.alpha = 0
            }) { (_) in
                self.floatingDimView.isHidden = true
            }

            buttons.reversed().forEach { button in
                UIView.animate(withDuration: 0.3) {
                    button.alpha = 0
                    self.view.layoutIfNeeded()
                } completion: { _ in
                    button.isHidden = true
                }
            }
        } else {
            // 약 추가 목록버튼모달 만들기
            self.floatingDimView.isHidden = false
            self.floatingDimView.alpha = 0

            UIView.animate(withDuration: 0.3) {
                self.floatingDimView.alpha = 0.7
            }

            buttons.forEach { [weak self] button in
                button.isHidden = false
                button.alpha = 0

                UIView.animate(withDuration: 0.3) {
                    button.alpha = 1
                    self?.view.layoutIfNeeded()
                }
            }
        }


         isShowFloating = !isShowFloating

         let image = isShowFloating ? UIImage(named: "button-add-pill") : UIImage(named: "FAB-add-pill")
         let roatation = isShowFloating ? CGAffineTransform(rotationAngle: .pi - (.pi / 4)) : CGAffineTransform.identity

         UIView.animate(withDuration: 0.3) {
             sender.setImage(image, for: .normal)
             sender.transform = roatation
         }

     }

}
