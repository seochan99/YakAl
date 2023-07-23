import UIKit

//MARK: - STEP 2 생년월일
class Step2VC: SignInViewController {
    @IBOutlet weak var birthPicker: UIDatePicker!
    
    @IBOutlet weak var nextButton: UIButton!
    
    // Add 'user' property
     var user: User!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = " " // 원하는 타이틀을 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "이름"
        myStepNumber = 2
        
        // maybe some other stuff specific to this "step"
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        user.step2Input = birthPicker.date

        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInScreen5VC = storyboard.instantiateViewController(withIdentifier: "SignInScreen_5") as! Step3VC
        
        signInScreen5VC.user = user
        navigationController?.pushViewController(signInScreen5VC, animated: true)
    }
}
