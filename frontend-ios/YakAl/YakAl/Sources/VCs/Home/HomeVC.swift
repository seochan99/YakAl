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
    
    
    @IBOutlet weak var emptyView: UIView!
    
    @IBOutlet weak var addModalView: UIView!
    @IBOutlet weak var AddModalButtonView: UIView!
    
    @IBOutlet weak var alertButton: UIButton!
    //    버튼
    @IBOutlet weak var EnvelopeMedicineButton: UIButton!
    @IBOutlet weak var normalMedicineButton: UIButton!
    @IBOutlet weak var DirectMedicineButton: UIButton!
    
    @IBOutlet weak var addMedicineButton: UIButton!
    
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
        
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TodoCell {
            // Toggle the expanded state of the TodoCell and reload the collection view
            cell.isExpanded = !cell.isExpanded
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    // UICollectionViewDelegateFlowLayout
    // device마다 cell크기가 달라야함
    // 셀 사이즈를 계산할거다!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let cellWidth = collectionView.bounds.width - 40
           let innerCellHeight: CGFloat = 40 // Height of the inner cell
           var outerCellHeight: CGFloat = 90 // Initial height of the outer cell
           
           if let cell = collectionView.cellForItem(at: indexPath) as? TodoCell {
               if cell.isExpanded {
                   if indexPath.item < viewModel.TodoItemList.count {
                       let todoItem = viewModel.TodoItemList[indexPath.item]
                       let numberOfMedicines = viewModel.numberOfMedicines(for: todoItem)
                       outerCellHeight += CGFloat(numberOfMedicines) * innerCellHeight + 20
                   }
               }
           }
           
           return CGSize(width: cellWidth, height: outerCellHeight)
       }
    
    // UIColor 객체를 #E9E9EE 색상으로 생성
    let borderColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
    
        //MARK: - viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            setupProgressCircle()
            updateEmptyViewVisibility()
            
            
            
//               // Register MedicineCell
//               let medicineCellNib = UINib(nibName: "MedicineCell", bundle: nil)
//               medicationCollectionView.register(medicineCellNib, forCellWithReuseIdentifier: "MedicineCell")
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

//MARK: - ViewModel
class TodoViewModel{
    let TodoItemList: [TodoItem] = [
        TodoItem(mealTime: .breakfast, medication: [
            Medicine(id: 1, image: "image_덱시로펜정", name: "덱시로펜정", ingredients: "성분 A", dangerImage: "Green-Light", isTaken: false),
            Medicine(id: 2, image: "image_덱시로펜정", name: "동화디트로판정", ingredients: "성분 B", dangerImage: "Yellow-Light", isTaken: false)
        ]),
        TodoItem(mealTime: .lunch, medication: [
            Medicine(id: 3, image: "image_덱시로펜정", name: "약물C", ingredients: "성분 C", dangerImage: "Green-Light", isTaken: false),
            Medicine(id: 4, image: "image_덱시로펜정", name: "약물D", ingredients: "성분 D", dangerImage: "Green-Light", isTaken: false)
        ]),
        TodoItem(mealTime: .dinner, medication: [
            Medicine(id: 5, image: "image_덱시로펜정", name: "약물E", ingredients: "성분 E", dangerImage: "Red-Light", isTaken: false),
            Medicine(id: 6, image: "image_덱시로펜정", name: "약물F", ingredients: "성분 F", dangerImage: "Red-Light", isTaken: false)
        ]),
        TodoItem(mealTime: .etc, medication: [
            Medicine(id: 7, image: "image_덱시로펜정", name: "약물G", ingredients: "성분 G", dangerImage: "Yellow-Light", isTaken: false),
            Medicine(id: 8, image: "image_덱시로펜정", name: "약물H", ingredients: "성분 H", dangerImage: "Yellow-Light", isTaken: false),
            Medicine(id: 9, image: "image_덱시로펜정", name: "약물J", ingredients: "성분 J", dangerImage: "Yellow-Light", isTaken: false)
        ])
    ]

    func numberOfMedicines(for todoItem: TodoItem) -> Int {
        return todoItem.medication.count
    }
    
    // 총 갯수 반환
    var numOfTodoList: Int{
        return TodoItemList.count
    }
}

//MARK: - TodoCell
class TodoCell: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var todoIcon: UIImageView!
    @IBOutlet weak var todoAllDoneBtn: UIButton!
    @IBOutlet weak var todoNowCnt: UILabel!
    @IBOutlet weak var todoTime2: UILabel!
    @IBOutlet weak var todoTotalCnt: UILabel!
    @IBOutlet weak var medicationCollectionView: UICollectionView!

    @IBOutlet weak var firstDivinder: UIView!
    
    
    
    @IBOutlet weak var secondDivinder: UIView!
    
    var medicines: [Medicine] = []
    
    var isExpanded: Bool = false {
        didSet {
            print("확장여부는 \(isExpanded) 입니다!")
            medicationCollectionView.reloadData()
            updateTodoIconImage()
        }
    }
    func updateTodoIconImage() {
        let imageName = isExpanded ? "icon-mainpill(1)" : "icon-mainpill(2)"
        todoIcon.image = UIImage(named: imageName)
        // Update the border color based on isExpanded
        let borderColor = isExpanded ? UIColor(red: 85/255, green: 136/255, blue: 253/255, alpha: 1) : UIColor(red: 233/255, green: 233/255, blue: 238/255, alpha: 1)
        firstDivinder.isHidden = !isExpanded
        // Apply border and corner radius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        
        // Apply shadow
        self.layer.shadowColor = UIColor(red: 98/255, green: 98/255, blue: 114/255, alpha: 0.2).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
    
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Apply styling to the cell
               self.layer.cornerRadius = 16
               self.layer.masksToBounds = false
               self.layer.borderWidth = 1
               self.layer.borderColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 238.0/255.0, alpha: 1.0).cgColor
               
               // Apply shadow
               self.layer.shadowColor = UIColor(red: 98/255, green: 98/255, blue: 114/255, alpha: 0.20).cgColor
               self.layer.shadowOffset = CGSize(width: 0, height: 2)
               self.layer.shadowOpacity = 1
               self.layer.shadowRadius = 6
        
        // Set the width constraint of secondDivinder
        secondDivinder.translatesAutoresizingMaskIntoConstraints = false
        secondDivinder.widthAnchor.constraint(equalToConstant: 60).isActive = true
        secondDivinder.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true


    }

    
    // TodoItem의 medication리스트 길이만큼 todoTotalCnt 할당 하기
    func update(info: TodoItem) {
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
        
        // todoTotalCnt 설정
        todoTotalCnt.text = String(info.medication.count) + "개"
        
        // medicines 배열 초기화
        medicines = info.medication
        
        // 업데이트 후 collectionView 리로드
        medicationCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medicines.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MedicineCell", for: indexPath) as? MedicineCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.item < medicines.count {
            let medicine = medicines[indexPath.item]
            cell.update(info: medicine)
        }
        
        return cell
    }

    
    // 전체 확인 버튼
    @IBAction func AllAproveButtonOn(_ sender: UIButton) {
        
        let allButtons = [todoAllDoneBtn]
        
        // 전체 동의 버튼의 상태에 따라 모든 버튼을 On 또는 Off로 설정
        let isAllOn = todoAllDoneBtn.isSelected
        
        // 모든 버튼 반복문 돌면서 상태 변경
        for button in allButtons {
            button?.isSelected = !isAllOn
            updateButtonAppearance(button ?? todoAllDoneBtn)
        }
        
    }

    // 버튼 상태 변경
    public func changeButtonState(_ sender:UIButton){
        let isOn = sender.isSelected
        sender.isSelected = !isOn
        updateButtonAppearance(sender)
    }

    // 버튼의 상태에 따라 색상 변경
    public func updateButtonAppearance(_ button: UIButton) {
        let selectedImage = UIImage(named: "Check_disable_ing")
        let deselectedImage = UIImage(named: "Check_disable")
        
        if button.isSelected {
            button.setImage(selectedImage, for: .normal)
        } else {
            button.setImage(deselectedImage, for: .normal)
        }
    }

}
    
//MARK: - Medicine Cell
class MedicineCell: UICollectionViewCell {
    @IBOutlet weak var medicineIcon: UIImageView!
    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var medicineIngredientsLabel: UILabel!
    @IBOutlet weak var medicineDangerIcon: UIImageView!
    @IBOutlet weak var medineEatButton: UIButton!
    
    
    func update(info: Medicine) {
        medicineIcon.image = UIImage(named: info.image)
        medicineNameLabel.text = info.name
        medicineIngredientsLabel.text = info.ingredients
        medicineDangerIcon.image = UIImage(named: info.dangerImage)
    }
}
    
