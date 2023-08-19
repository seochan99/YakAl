import UIKit
import SwiftUI



class MedicationData: ObservableObject {
    @Published var medications: [Medication] = [
//        Medication(name: "아침",medication: [
//            Medicine(id: 1, image: "image_덱시로펜정", name: "덱시로펜정", ingredients: "해열, 진통, 소염제", dangerStat: 0, isTaken: false),
//            Medicine(id: 2, image: "image_덱시로펜정", name: "동화디트로판정", ingredients: "소화성 궤양용제", dangerStat: 1, isTaken: false),
//            Medicine(id: 3, image: "image_덱시로펜정", name: "동광레바미피드정", ingredients: "소화성 궤양용제", dangerStat: 1, isTaken: false)
//        ]),
//        Medication(name: "점심",medication: [
//            Medicine(id: 3, image: "image_덱시로펜정", name: "약물C", ingredients: "성분 C", dangerStat: 2, isTaken: false),
//            Medicine(id: 4, image: "image_덱시로펜정", name: "약물D", ingredients: "성분 D", dangerStat: 1, isTaken: false)
//        ]),
//        Medication(name: "저녁", medication: [
//            Medicine(id: 5, image: "image_덱시로펜정", name: "약물E", ingredients: "성분 E", dangerStat: 2, isTaken: false),
//            Medicine(id: 6, image: "image_덱시로펜정", name: "약물F", ingredients: "성분 F", dangerStat: 1, isTaken: false)
//        ]),
//        Medication(name: "기타",medication: [
//            Medicine(id: 7, image: "image_덱시로펜정", name: "약물G", ingredients: "성분 G", dangerStat: 0, isTaken: false),
//            Medicine(id: 8, image: "image_덱시로펜정", name: "약물H", ingredients: "성분 H", dangerStat: 1, isTaken: false),
//            Medicine(id: 9, image: "image_덱시로펜정", name: "약물J", ingredients: "성분 J", dangerStat: 2, isTaken: false)
//        ]),
    ]
}

class HomeVC: UIViewController{
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
    
    
    // MARK: - Properties
    let progressCircle = CAShapeLayer()
    let progressCircle2 = CAShapeLayer()
    let progressLabel = UILabel()
    var currentProgress: CGFloat = 0


    
    // 버튼들이 들어있는 모달 뷰
    lazy var buttons: [UIView] = [self.addModalView]
    
    // 플로팅 버튼 상태에 대한 플래그
    var isShowFloating: Bool = false
    
    
    var medicationData = MedicationData()
    var medicationHostingController: UIHostingController<MedicationSwiftUIView>?


    
    // 배경 어둡게 만드는 view
    lazy var floatingDimView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - (self.tabBarController?.tabBar.frame.height ?? 0)))
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        view.alpha = 0
        view.isHidden = true
        
        self.view.insertSubview(view, belowSubview: self.floatingStackView)
        
        return view
    }()
    
    
    // UIColor 객체를 #E9E9EE 색상으로 생성
    let borderColor = UIColor(red: 233.0/255.0, green: 233.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
    
        //MARK: - viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            NSLayoutConstraint.activate([
                emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                emptyView.topAnchor.constraint(equalTo: view.topAnchor),
                emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

            
            if medicationData.medications.isEmpty {
                emptyView.isHidden = false
                self.view.bringSubviewToFront(floatingStackView)


                
            }else{
                self.view.bringSubviewToFront(floatingStackView)
                // Swift UI View만들기
                    let medicationSwiftUIView = MedicationSwiftUIView()
                        .environmentObject(medicationData)
                    
                    
                    let medicationHostingController = UIHostingController(rootView: medicationSwiftUIView)
                    addChild(medicationHostingController)
                    medicationHostingController.view.translatesAutoresizingMaskIntoConstraints = false
                    // Empty View에 붙이기
                    emptyView.addSubview(medicationHostingController.view)
                    NSLayoutConstraint.activate([
                        medicationHostingController.view.topAnchor.constraint(equalTo: emptyView.topAnchor),
                        medicationHostingController.view.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor),
                        medicationHostingController.view.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor),
                        medicationHostingController.view.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor)
                    ])
                    
                    medicationHostingController.didMove(toParent: self)
            }
                floatingStackView.isHidden = false
                setupProgressCircle()
            
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
