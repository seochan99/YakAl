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
        let medicine = Binding.constant( Medicine(id: 1, image: "image_덱시로펜정", name: "덱시로펜정", ingredients: "해열, 진통, 소염제", dangerStat: 0, isTaken: false))
        
        return MedicineDetailView(medicine: medicine)
    }
}
