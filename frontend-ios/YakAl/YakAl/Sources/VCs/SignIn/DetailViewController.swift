import UIKit



class DetailViewController1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chageNaviTitle(titleText: "서비스 이용약관")
        changeNaviBack()
    }
}


class DetailViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        chageNaviTitle(titleText: "위치기반 서비스 이용약관 동의")
        changeNaviBack()
        
    }
}


class DetailViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        chageNaviTitle(titleText: "개인정보 수집 및 이용 동의")
        changeNaviBack()
        
    }
}

class DetailViewController4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        let yourBackImage = UIImage(named: "icon_X")
//        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        chageNaviTitle(titleText: "마케팅 정보 활용 동의")
        changeNaviBack()
        
    }
}

extension UIViewController {
    func changeNaviBack() {
        
        
        let backButtonTitle = "뒤로"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: backButtonTitle, style: .plain, target: nil, action: nil)
        
        // Customize the back button text color to #626272
        navigationController?.navigationBar.tintColor = UIColor(red: 98/255, green: 98/255, blue: 114/255, alpha: 1.0)
    }
    
    func chageNaviTitle(titleText:String){
        let titleText = titleText
              let attributes: [NSAttributedString.Key: Any] = [
                  .font: UIFont(name: "SUIT-Bold", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0, weight: .bold),
                  .foregroundColor: UIColor.black,
                  .strokeWidth: -2.0 // Use a negative value to indicate bold style
              ]

              self.navigationItem.title = NSAttributedString(string: titleText, attributes: attributes).string
    }
}
