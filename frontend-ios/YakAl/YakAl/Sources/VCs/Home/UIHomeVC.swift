import SwiftUI

struct Medication: Identifiable {
    let id = UUID()
    let name: String
    var completedCount: Int = 0 // 복용한 약
    // 모두 먹었는지
    var isAllCompleted: Bool {
        return completedCount == count
    }
    let medication: [Medicine]
    var count: Int {
        return medication.count
    }
}

//MARK: - MedicationSwiftUIView : 시간대별 약물 데이터
struct MedicationSwiftUIView: View {
    @State private var expandedIndex: Int? = nil

    let medications: [Medication] = [
        Medication(name: "아침",medication: [
            Medicine(id: 1, image: "image_덱시로펜정", name: "덱시로펜정", ingredients: "해열, 진통, 소염제", dangerStat: 0, isTaken: false),
            Medicine(id: 2, image: "image_덱시로펜정", name: "동화디트로판정", ingredients: "소화성 궤양용제", dangerStat: 1, isTaken: false),
            Medicine(id: 3, image: "image_덱시로펜정", name: "동광레바미피드정", ingredients: "소화성 궤양용제", dangerStat: 1, isTaken: false)
        ]),
        Medication(name: "점심",medication: [
            Medicine(id: 3, image: "image_덱시로펜정", name: "약물C", ingredients: "성분 C", dangerStat: 2, isTaken: false),
            Medicine(id: 4, image: "image_덱시로펜정", name: "약물D", ingredients: "성분 D", dangerStat: 1, isTaken: false)
        ]),
        Medication(name: "저녁", medication: [
            Medicine(id: 5, image: "image_덱시로펜정", name: "약물E", ingredients: "성분 E", dangerStat: 2, isTaken: false),
            Medicine(id: 6, image: "image_덱시로펜정", name: "약물F", ingredients: "성분 F", dangerStat: 1, isTaken: false)
        ]),
        Medication(name: "기타",medication: [
            Medicine(id: 7, image: "image_덱시로펜정", name: "약물G", ingredients: "성분 G", dangerStat: 0, isTaken: false),
            Medicine(id: 8, image: "image_덱시로펜정", name: "약물H", ingredients: "성분 H", dangerStat: 1, isTaken: false),
            Medicine(id: 9, image: "image_덱시로펜정", name: "약물J", ingredients: "성분 J", dangerStat: 2, isTaken: false)
        ]),
    ]
//
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(medications.indices, id: \.self) { index in
                    MedicationRow(
                        medication: medications[index],
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
                 if medication.isAllCompleted {

                     Text("모두 완료")
                         .font(
                             Font.custom("SUIT", size: 14)
                                 .weight(.semibold)
                         )
                         .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.81))
                     Button(action: {
                         medication.completedCount = 0 // Reset completed count
                     }) {
                         Image("Check_disable_end")
                             .resizable()
                             .frame(width: 36, height: 36)
                     }
                 } else {
                     
                     if medication.completedCount == 0{
                         Text("모두 완료")
                             .font(
                                 Font.custom("SUIT", size: 14)
                                     .weight(.semibold)
                             )
                             .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.81))
                         
                     }
                     else{
                         Text("\(medication.completedCount)개 완료")
                             .font(
                                 Font.custom("SUIT", size: 14)
                                     .weight(.semibold)
                             )
                             .foregroundColor(Color(red: 0.78, green: 0.78, blue: 0.81))
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
                         medicine: medication.medication[index], // Use the medicine from the Medication model
                         isCompleted: Binding(
                             get: {
                                 index < medication.completedCount // Changed to index < completedCount
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
    let medicine: Medicine
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
            }) {
                Image(isCompleted ? "Check_disable_ing" : "Check_disable")
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
        MedicationSwiftUIView()
            .previewLayout(.sizeThatFits)
    }
}
