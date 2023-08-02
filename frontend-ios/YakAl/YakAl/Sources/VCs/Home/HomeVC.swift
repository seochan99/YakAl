//
//  HomeViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit

class HomeVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var myTodoTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var addModalView: UIView!
    

    
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
    override func viewDidLoad() {


        // calendarView의 레이어(border)의 색상을 설정
        calendarView.layer.borderColor = borderColor.cgColor
        addModalView.layer.borderColor = borderColor.cgColor
        super.viewDidLoad()
    }
    
    
    // 아래 메서드를 사용하여 emptyView의 상태를 갱신합니다.
    func updateEmptyViewVisibility() {
        if myTodoItems.count == 0 {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }

}
