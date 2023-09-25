import UIKit
import SwiftUI

enum StoryboardIdentifier2: String {
    case main = "Home"
}

enum ViewControllerIdentifier2: String {
    case mainVC = "MedicineAddDirectVC" // "MainVC"는 Main 스토리보드의 ViewController의 Identity로 설정한 값입니다.
}

class MedicineAddDirectVC: UIViewController {
    var profileHostingController: UIHostingController<DirectAddMedicineSwiftUIView>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let profileSwiftUIView = DirectAddMedicineSwiftUIView()
        
        let profileHostingController = UIHostingController(rootView: profileSwiftUIView)
        addChild(profileHostingController)
        profileHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        // Add CalendarSwiftUIView to the main view
        view.addSubview(profileHostingController.view)
        NSLayoutConstraint.activate([
            profileHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            profileHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        profileHostingController.didMove(toParent: self)
    }
}
