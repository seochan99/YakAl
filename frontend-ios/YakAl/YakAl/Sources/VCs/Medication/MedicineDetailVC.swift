import UIKit
import SwiftUI

class MedicineObject: ObservableObject {
    @Published var medicine: Medicine? // Not optional anymore, initialize it with a default value if necessary
}

struct MedicineDetailViewControllerWrapper: UIViewControllerRepresentable {
    var medicine: Medicine

    func makeUIViewController(context: Context) -> MedicineDetailVC {
        let viewController = MedicineDetailVC()
        viewController.medicine = medicine
        return viewController
    }

    func updateUIViewController(_ uiViewController: MedicineDetailVC, context: Context) {
        // No update code needed
    }
}


class MedicineDetailVC: UIViewController {
    var medicine: Medicine? // New property to hold the medicine object
    var medicineObject = MedicineObject() // This is the observable object

    var calendarHostingController: UIHostingController<MedicineDetailView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let medicine = medicine else {
                  return // Handle this case appropriately
              }
              
              medicineObject.medicine = medicine // Setting the medicine object here

              let medicineBinding = Binding<Medicine>(
                get: { self.medicineObject.medicine! },
                  set: { self.medicineObject.medicine = $0 }
              )

        let calendarSwiftUIView = MedicineDetailView(medicine: medicineBinding)

        
        let calendarHostingController = UIHostingController(rootView: calendarSwiftUIView)
        addChild(calendarHostingController)
        calendarHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        // Add CalendarSwiftUIView to the main view
        view.addSubview(calendarHostingController.view)
        NSLayoutConstraint.activate([
            calendarHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            calendarHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        calendarHostingController.didMove(toParent: self)
    }

}
