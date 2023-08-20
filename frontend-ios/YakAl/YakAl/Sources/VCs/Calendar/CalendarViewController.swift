import UIKit
import SwiftUI

class CalendarViewController: UIViewController {

    var calendarHostingController: UIHostingController<CalendarSwiftUIView>?
    var medicationData = MedicationData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarSwiftUIView = CalendarSwiftUIView()
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
