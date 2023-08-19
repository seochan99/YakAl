import SwiftUI
import Combine


//MARK: - MedicationSwiftUIView : 시간대별 약물 데이터
struct MedicationSwiftUIView: View {
    // 확장 여부
    @State private var expandedIndex: Int? = nil
    // 데이터 받아오기
    @EnvironmentObject private var medicationData: MedicationData

    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(medicationData.medications.indices, id: \.self) { index in
                    MedicationRow(
                        medication: medicationData.medications[index],
                        isExpanded: expandedIndex == index,
                        onTap: {
                            withAnimation {
                                expandedIndex = expandedIndex == index ? nil : index
                            }
                        }
                    )
                }
            }
            .padding()
        }
    }
}

//MARK: - 약물 상단 Row
struct MedicationRow: View {
    @State var medication: Medication // Change let to var

    let isExpanded: Bool
    let onTap: () -> Void

    var body: some View {
         VStack(spacing: 20) {
             Spacer()
             HStack(spacing: 8) {
                 Image(isExpanded ? "icon-mainpill(1)" : "icon-mainpill(2)")
                     .resizable()
                     .frame(width: 28, height: 28)
                 Text(medication.name)
                     .font(
                         Font.custom("SUIT", size: 20)
                             .weight(.semibold)
                     )
                     .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                 Text("\(medication.count)개")
                     .font(
                         Font.custom("SUIT", size: 14)
                             .weight(.bold)
                     )
                     .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))
                 Spacer()
                 // 만약 모든 약물 복용이 체크된다면
                 if medication.isAllCompleted {

                     Text("모두 완료")
                         .font(
                             Font.custom("SUIT", size: 14)
                                 .weight(.semibold)
                         )
                         .foregroundColor(Color(red: 0.15, green: 0.4, blue: 0.96))
                     Button(action: {
                         medication.completedCount = 0 // Reset completed count
                     }) {
                         Image("Check_disable_end")
                             .resizable()
                             .frame(width: 36, height: 36)
                     }
                 } else {
                     // 그외에 0개 체크시
                     if medication.completedCount == 0{
                         Text("모두 완료")
                             .font(
                                 Font.custom("SUIT", size: 14)
                                     .weight(.semibold)
                             )
                             .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.81))
                         
                     }
                     // 그외에 1개 체크시
                     else{
                         Text("\(medication.completedCount)개 완료")
                             .font(
                                 Font.custom("SUIT", size: 14)
                                     .weight(.semibold)
                             )
                             .foregroundColor(Color(red: 0.15, green: 0.4, blue: 0.96))

                     }
                     

                     Button(action: {
                         medication.completedCount = medication.count // Mark all as completed
                     }) {
                         Image(medication.completedCount == 0 ? "Check_disable" : "Check_disable_ing")
                             .resizable()
                             .frame(width: 36, height: 36)
                     }
                 }
             }
             .padding(.horizontal, 16)
             .foregroundColor(.black)
             .background(
                 RoundedRectangle(cornerRadius: 16)
                     .foregroundColor(.white)
             )
             .onTapGesture {
                 onTap()
             }

             // 확장시
             if isExpanded {
                 Rectangle()
                   .foregroundColor(.clear)
                   .background(Color(red: 0.96, green: 0.96, blue: 0.98))
                   .padding(.horizontal,10)
                   .frame(height: 2)
                 ForEach(medication.medication.indices, id: \.self) { index in
                     MedicationItemRow(
                        // 약물 정보
                         medicine: medication.medication[index], // Use the medicine from the Medication model
                         // 모두 완료여부
                         isAllCompleted : medication.isAllCompleted,
                         // 완료 여부
                         isCompleted: Binding(
                             get: {
                                 index < medication.completedCount
                             },
                             set: { newValue in
                                 if newValue {
                                     medication.completedCount += 1
                                 } else {
                                     medication.completedCount -= 1
                                 }
                             }
                         )
                     )
                 }
                 .padding(.horizontal,0)
             }
             Rectangle()
             .foregroundColor(.clear)
             .frame(width: 60, height: 4)
             .background(Color(red: 0.91, green: 0.91, blue: 0.93))
             .cornerRadius(2)
             Spacer()

         }
         .overlay(
             RoundedRectangle(cornerRadius: 16)
                 .inset(by: 0.5)
                 .stroke(isExpanded ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 1)
                 .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.45).opacity(0.2), radius: 3, x: 0, y: 2)
         )
     }
}

//MARK: - 약 개별 Row
struct MedicationItemRow: View {
    @State var medicine: Medicine
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
                .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
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
                isCompleted.toggle()
                medicine.isTaken = isCompleted

            }) {
                Image(isAllCompleted ? "Check_disable_end" : (isCompleted ? "Check_disable_ing" : "Check_disable"))
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal,16)
    }
}


@available(iOS 15.0, *)
struct MedicationSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AnyView(MedicationSwiftUIView()
            .environmentObject(MedicationData()))
            .previewLayout(.sizeThatFits)
    }
}
