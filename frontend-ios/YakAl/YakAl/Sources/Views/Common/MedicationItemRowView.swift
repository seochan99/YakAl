import SwiftUI
//MARK: - 약 개별 Row
struct MedicationItemRow: View {
    @Binding var medicine: Medicine
    let isAllCompleted: Bool // Add this parameter
    @Binding var isCompleted: Bool

    var body: some View {
        HStack(spacing: 16) {
            Image(medicine.image)
                .resizable()
                .frame(width: 64, height: 32)
            VStack(alignment: .leading,spacing:2){
                Text(medicine.name)
                .font(
                Font.custom("SUIT", size: 14)
                .weight(.medium)
                )
                .foregroundColor(medicine.dangerStat == 2 ?  Color(red: 0.88, green: 0.06, blue: 0.16) : Color(red: 0.08, green: 0.08, blue: 0.08))
                Text("해열, 진통, 소염제")
                .font(
                Font.custom("SUIT", size: 10)
                .weight(.medium)
                )
                .foregroundColor(Color(red: 0.51, green: 0.5, blue: 0.59))
            }
            .padding(.vertical,3)
            
            
            
            Spacer()
            if medicine.dangerStat == 0 {
                Image("Green-Light")
                    .resizable()
                    .frame(width: 16, height: 16)
            } else if medicine.dangerStat == 1 {
                Image("Yellow-Light") // Change to the appropriate image
                    .resizable()
                    .frame(width: 16, height: 16)
            } else if medicine.dangerStat == 2 {
                Image("Red-Light")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            Button(action: {
                medicine.isTaken.toggle()
                isCompleted = medicine.isTaken
//                print("isCompleted : \(isCompleted)")
//                print("medicine.isTaken : \(medicine.isTaken)")
            }) {
                Image(isAllCompleted ? "Check_disable_end" : (medicine.isTaken ? "Check_disable_ing" : "Check_disable"))
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal,16)
          }
}
struct MedicationItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        let medicine = Binding<Medicine>(
            get: { Medicine(id: 1, image: "image_덱시로펜정", name: "Medicine Name", ingredients: "Ingredient 1, Ingredient 2", dangerStat: 0, isTaken: false) },
            set: { newValue in }
        )
        
        MedicationItemRow(
            medicine: medicine,
            isAllCompleted: false,
            isCompleted: .constant(false)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
