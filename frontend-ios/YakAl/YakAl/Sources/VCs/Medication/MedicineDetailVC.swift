import UIKit
import SwiftUI


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

    var calendarHostingController: UIHostingController<MedicineDetailView>?
    var medicationData = MedicationData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let medicine = medicine else {
            return
         }
        let medicineBinding = Binding<Medicine>(
                  get: { medicine },
                  set: { self.medicine = $0 }
              )
        
        let calendarSwiftUIView = MedicineDetailView(medicine: medicineBinding)
            .environmentObject(medicationData)
        
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
