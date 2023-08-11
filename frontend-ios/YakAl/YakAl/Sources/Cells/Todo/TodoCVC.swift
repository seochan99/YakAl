//
//  TodoCVC.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/11.
//

import UIKit

// Todo Cell
class TodoCVC: UICollectionViewCell{
    @IBOutlet weak var todoIcon: UIImageView!
    @IBOutlet weak var todoAllDoneBtn: UIButton!
    @IBOutlet weak var todoNowCnt: UILabel!
    @IBOutlet weak var todoTime2: UILabel!
    @IBOutlet weak var todoTotalCnt: UILabel!
    @IBOutlet weak var medicationCollectionView: UICollectionView!

    
    override func awakeFromNib() {

        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    
    // TodoItem의 medication리스트 길이만큼 todoTotalCnt 할당 하기

    func update(info: TodoItem){
        // info값 출력
        print("info값 출력")
        print(info)
    // TodoItem 의 mealTime에 따라 todoTime2 할당하기
        switch info.mealTime {
        case .breakfast:
            todoTime2.text = "아침"
        case .lunch:
            todoTime2.text = "점심"
        case .dinner:
            todoTime2.text = "저녁"
        case .etc:
            todoTime2.text = "기타"
        }
        todoTotalCnt.text = String(info.medication.count)+"개"
    }
    
    
    
}
    
