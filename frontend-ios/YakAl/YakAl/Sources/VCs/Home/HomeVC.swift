//
//  HomeViewController.swift
//  YakAl
//
//  Created by 서희찬 on 2023/07/12.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    // MARK: - Outlets -
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var floatingStackView: UIStackView!
    
    @IBOutlet weak var myTodoTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var addModalView: UIView!
    @IBOutlet weak var AddModalButtonView: UIView!
    
    @IBOutlet weak var alertButton: UIButton!
    //    버튼
    @IBOutlet weak var EnvelopeMedicineButton: UIButton!
    @IBOutlet weak var normalMedicineButton: UIButton!
    @IBOutlet weak var DirectMedicineButton: UIButton!
    
    @IBOutlet weak var addMedicineButton: UIButton!
    
    @IBOutlet weak var animatedCountingLabel: UILabel!
    
    // MARK: - Properties -
    
    let progressCircle = CAShapeLayer()
    let progressCircle2 = CAShapeLayer()
    let progressLabel = UILabel()
    var currentProgress: CGFloat = 0
    
    
    
    // 버튼들이 들어있는 모달 뷰
    lazy var buttons: [UIView] = [self.addModalView]
    
    let viewModel = TodoViewModel()
    
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
    
//    var myTodoItems: [TodoItem] = []
    
    
    
    // 몇개
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfTodoList
    }
    
    
    
    // 셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodoCell", for: indexPath) as? TodoCell else {
            return UICollectionViewCell()
        }
        
        let todoItem = viewModel.TodoItemList[indexPath.item]
        cell.update(info: todoItem)
        
        return cell
    }
    
    // UICollectionViewDelegate
    // 셀이 클릭되었을때 우짤까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
//        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    
    // UICollectionViewDelegateFlowLayout
    // device마다 cell크기가 달라야함
    // 셀 사이즈를 계산할거다!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width - 40
        let cellHeight: CGFloat = 120 // Adjust the value as needed
        return CGSize(width: cellWidth, height: cellHeight)
    }
        // UIColor 객체를 #E9E9EE 색상으로 생성
        let borderColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
        
        
        //MARK: - viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            setupProgressCircle()
            updateEmptyViewVisibility()
            
            
            // calendarView의 레이어(border)의 색상을 설정
            calendarView.layer.borderColor = borderColor.cgColor
            addModalView.layer.borderColor = borderColor.cgColor
            
        }
        
        func setupProgressCircle() {
            // 진행바 원 중심의 x 좌표와 y 좌표 설정
            let centerX = view.bounds.width - 70
            let centerY = CGFloat(175)
            
            // 원형 경로 생성
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY),
                                            radius: 40,
                                            startAngle: -CGFloat.pi / 2,
                                            endAngle: 3 * CGFloat.pi / 2,
                                            clockwise: true)
            // 이전 경로 생성
            let beforeCircularPath = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY),
                                                  radius: 40,
                                                  startAngle: -CGFloat.pi / 2,
                                                  endAngle: 3 * CGFloat.pi / 2,
                                                  clockwise: true)
            
            progressCircle2.path = beforeCircularPath.cgPath
            progressCircle2.strokeColor = UIColor(red: 193/255, green: 210/255, blue: 255/255, alpha: 1).cgColor // #C1D2FF
            progressCircle2.fillColor = UIColor.clear.cgColor
            progressCircle2.lineWidth = 4
            progressCircle2.strokeEnd = 1
            view.layer.addSublayer(progressCircle2)
            
            // 진행바 레이어 설정
            progressCircle.path = circularPath.cgPath
            progressCircle.strokeColor = UIColor(red: 193/255, green: 210/255, blue: 255/255, alpha: 1).cgColor // #C1D2FF
            progressCircle.fillColor = UIColor.clear.cgColor
            progressCircle.lineWidth = 4
            progressCircle.strokeEnd = 0
            view.layer.addSublayer(progressCircle)
            
            
            
            
            // 진행 상태 레이블 설정
            progressLabel.frame = CGRect(x: centerX - 40, y: centerY - 20, width: 80, height: 40)
            progressLabel.textAlignment = .center
            if currentProgress == 0 {
                progressLabel.textColor = UIColor(red: 193/255, green: 210/255, blue: 255/255, alpha: 1) // #5588FD
            }else{
                progressLabel.textColor = UIColor(red: 85/255, green: 136/255, blue: 253/255, alpha: 1) // #5588FD
            }
            
            progressLabel.font = UIFont.boldSystemFont(ofSize: 20)
            progressLabel.text = "0%"
            view.addSubview(progressLabel)
        }
        
        func animateProgress() {
            // 현재 진행 상태를 0.1만큼 증가시킵니다.
            currentProgress += 0.1
            
            // 진행 상태가 1보다 크면 1로 설정합니다.
            if currentProgress > 1 {
                currentProgress = 1
            }
            
            // 진행 상태에 따른 progressCircle의 색상 변경
            let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
            colorAnimation.toValue = UIColor(red: 85/255, green: 136/255, blue: 253/255, alpha: 1).cgColor // #5588FD
            colorAnimation.duration = 0
            colorAnimation.fillMode = .forwards
            colorAnimation.isRemovedOnCompletion = false
            progressCircle.add(colorAnimation, forKey: "colorAnimation")
            
            // 진행바 진행 애니메이션 설정
            let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            progressAnimation.toValue = currentProgress
            progressAnimation.duration = 0
            progressAnimation.fillMode = .forwards
            progressAnimation.isRemovedOnCompletion = false
            progressCircle.add(progressAnimation, forKey: "progressAnimation")
            
            // 진행 상태에 따른 progressLabel의 텍스트와 색상 변경
            let formattedProgress = String(format: "%.0f", currentProgress * 100)
            progressLabel.text = "\(formattedProgress)%"
            if currentProgress == 0 {
                progressLabel.textColor = UIColor(red: 193/255, green: 210/255, blue: 255/255, alpha: 1) // #C1D2FF
            } else {
                progressLabel.textColor = UIColor(red: 85/255, green: 136/255, blue: 253/255, alpha: 1)
                // #5588FD
            }
        }
        
        
        // 아래 메서드를 사용하여 emptyView의 상태를 갱신합니다.
        func updateEmptyViewVisibility() {
            
            if viewModel.numOfTodoList == 0 {
                emptyView.isHidden = false
            } else {
                emptyView.isHidden = true
            }
        }
        
        
        @IBAction func AlertButtonAction(_ sender: UIButton) {
            print("Alert")
            animateProgress()
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

// 2. viewModel 만들기
class TodoViewModel{
    let TodoItemList: [TodoItem] = [
        TodoItem(mealTime: .breakfast, medication: ["약물A", "약물B"]),
        TodoItem(mealTime: .lunch, medication: ["약물C", "약물D"]),
        TodoItem(mealTime: .dinner, medication: ["약물E", "약물F"]),
        TodoItem(mealTime: .etc, medication: ["약물G", "약물H","약물J"])
    ]
    // 총 갯수 반환
    var numOfTodoList: Int{
        print("numOfTodoList 함수 실행")
        return TodoItemList.count
    }
}
// TodoCell
class TodoCell: UICollectionViewCell{
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
    

class MedicineCell: UICollectionViewCell{
    func update(info: TodoItem){
        
    }
}
    
