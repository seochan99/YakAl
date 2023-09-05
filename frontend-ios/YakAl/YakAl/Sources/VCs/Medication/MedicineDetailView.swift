import SwiftUI

struct MedicineDetailView: View {
    @Binding var medicine: Medicine

    var body: some View {
        // Your detail view content using the provided medicine data
        Text("Medicine Detail: \(medicine.name)")
            .font(.title)
    }
}


struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let medicine = Binding.constant(     Medicine(
            id: 1,
            image: "image_덱시로펜정",
            name: "데크시로펜정",
            effect: "해열, 진통, 소염제",
            kdCode: "KD001",
            atcCode: AtcCode(code: "ATC001", score: 1),
            count: 10,
            isTaken: false,
            isOverLap: false
        ))
        
        return MedicineDetailView(medicine: medicine)
    }
}
