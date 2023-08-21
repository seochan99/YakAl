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
            .padding(.bottom, 90) // Add bottom padding here
        }.background(Color(red: 233.0/255.0, green: 233.0/255.0, blue: 238.0/255.0))
    }
}


// Preview
@available(iOS 15.0, *)
struct MedicationSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AnyView(MedicationSwiftUIView()
            .environmentObject(MedicationData()))
            .previewLayout(.sizeThatFits)
    }
}
