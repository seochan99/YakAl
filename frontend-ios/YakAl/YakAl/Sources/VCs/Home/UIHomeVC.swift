import SwiftUI

struct Medication: Identifiable {
    let id = UUID()
    let image: Image
    let name: String
}

struct MedicationSwiftUIView: View {
    let medications: [Medication] = [
        Medication(image: Image(systemName: "sun.max.fill"), name: "아침"),
        Medication(image: Image(systemName: "sun.max.fill"), name: "점심"),
        Medication(image: Image(systemName: "moon.fill"), name: "저녁"),
        // Add more medications here
    ]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(medications) { medication in
                    MedicationRow(medication: medication)
                }
            }
            .padding()
        }
    }
}


//MARK: - 약물 상단 Row
struct MedicationRow: View {
    let medication: Medication
    @State private var isExpanded: Bool = false

    var body: some View {
          VStack(spacing: 20) {
              Spacer()
              HStack(spacing: 10) {
                  medication.image
                      .resizable()
                      .frame(width: 30, height: 30)
                  Text(medication.name)
                  Spacer()
                  Text("모두완료")
                  Image(systemName: "checkmark.circle")
              }
              .padding(.horizontal)
              .foregroundColor(.black)
              .background(
                  RoundedRectangle(cornerRadius: 16)
                      .foregroundColor(.white)
              )
              .onTapGesture {
                  withAnimation {
                      isExpanded.toggle()
                  }
              }
              
              if isExpanded {
                  // Show medication list for this time
                  ForEach(1...5, id: \.self) { index in
                      MedicationItemRow(index: index)
                  }
                  .padding(.horizontal)
              }
              Spacer() // Add spacer at the bottom
          }.overlay( // 윤곽
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(isExpanded ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 1)
                .shadow(color: Color(red: 0.38, green: 0.38, blue: 0.45).opacity(0.2), radius: 3, x: 0, y: 2)
               
          )
        
        
      }
}

//MARK: - 약 개별 Row
struct MedicationItemRow: View {
    let index: Int

    var body: some View {
        HStack(spacing: 10) {
            Image("")
                .resizable()
                .frame(width: 20, height: 20)
            Text("약이름 \(index)")
            Spacer()
            Image(systemName: "checkmark.circle")
        }
        .padding(.horizontal)
    }
}

@available(iOS 15.0, *)
struct MedicationSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MedicationSwiftUIView()
            .previewLayout(.sizeThatFits)
    }
}
