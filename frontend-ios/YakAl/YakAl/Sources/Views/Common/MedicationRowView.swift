//
//  MedicationRowView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/20.
//

import SwiftUI

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
                     
                     // 버튼 클릭시 초기화 진행
                     Button(action: {
                         medication.completedCount = 0
                         // 모두 false로
                         for index in medication.medication.indices {
                                medication.medication[index].isTaken = false
                            }
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
                         for index in medication.medication.indices {
                                medication.medication[index].isTaken = true
                            }
                         
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
                        medicine: $medication.medication[index], // Use the binding to the instance

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
//                                     print("더할때 \(index) : \(medication.completedCount)")
                                 } else {
                                     medication.completedCount -= 1
//                                     print("뺄때 \(index) : \(medication.completedCount)")
                                 }
                             }
                         )
                     ).id(UUID())
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
         .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
         )
         .overlay(
             RoundedRectangle(cornerRadius: 16)
                 .inset(by: 0.5)
                 .stroke(isExpanded ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 1)
                 .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.45).opacity(0.2), radius: 3, x: 0, y: 2)
             
         )
     }
}
struct MedicationRowView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationRow(
            medication: Medication(name: "아침", medication: [
                Medicine(
                    id: 1,
                    image: "image_덱시로펜정",
                    name: "데크시로펜정",
                    effect: "해열, 진통, 소염제",
                    kdCode: "KD001",
                    atcCode: AtcCode(code: "ATC001", score: 1),
                    count: 10,
                    isTaken: false,
                    isOverLap: false
                ),
                Medicine(
                    id: 2,
                    image: "image_동광레바미피드정",
                    name: "동광레바미피드정",
                    effect: "소화성 궤양용제",
                    kdCode: "KD001",
                    atcCode: AtcCode(code: "ATC001", score: 1),
                    count: 10,
                    isTaken: false,
                    isOverLap: false
                ),
                
            ]),
            isExpanded: true, // or false, depending on your use case
            onTap: {}
        )
    }
}

