import SwiftUI
import Combine

struct DrugInfoResponse: Codable {
    let DrugInfo: DrugInfo
    let Message: String
}


class MedicineViewModel: ObservableObject {
    @Published var medicine: Medicine?
    @Published var identaImage: Image?
    @Published var responseString = "Loading..."

    private var imageCache: [String: Image] = [:]
    
    
    
    func fetchDrugInfo(kdCode: String) {
         print("kdcode는 이거임!! \(kdCode)")

         // 이미 캐시된 이미지가 있는 경우 그것을 사용
         if let cachedImage = imageCache[kdCode] {
             self.identaImage = cachedImage
             self.responseString = "Data fetched from cache"
             return
         }

         guard let url = URL(string: "https://api2.kims.co.kr/api/drug/info?drugcode=\(kdCode)&drugType=N") else {
             self.responseString = "Invalid URL"
             return
         }
  

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 유저네임, 패스워드
        let username = "DIVWPM"
        let password = "DIVWPM"
        let loginString = "\(username):\(password)"
        if let utf8Data = loginString.data(using: .utf8) {
            let base64LoginString = utf8Data.base64EncodedString()
            request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }
        
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(DrugInfoResponse.self, from: data)
                     DispatchQueue.main.async {
                         self.medicine?.drugInfo = response.DrugInfo // DrugInfo 저장

                         let base64String = response.DrugInfo.IdentaImage
                         if let imageData = Data(base64Encoded: base64String), let uiImage = UIImage(data: imageData) {
                             let image = Image(uiImage: uiImage)
                             self.identaImage = image
                             self.imageCache[kdCode] = image
                             self.responseString = "Data fetched successfully"
                         } else {
                             self.responseString = "Image decoding failed"
                         }
                     }
                } catch {
                    print("Error decoding JSON: \(error)")
                    DispatchQueue.main.async {
                        self.responseString = "Error decoding JSON: \(error.localizedDescription)"
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.responseString = "Request failed: \(error.localizedDescription)"
                }
            }
        }

        task.resume()
    }
}




//MARK: - 약 개별 Row
struct MedicationItemRow: View {
    @Binding var medicine: Medicine
    @ObservedObject var viewModel = MedicineViewModel()
    let isAllCompleted: Bool
    @State private var isDetailViewPresented: Bool = false

    @Binding var isCompleted: Bool
    @State private var responseString = "Loading..."

    
    var body: some View {
        HStack(spacing: 16) {
            HStack{
                if let image = viewModel.identaImage {
                    image
                        .resizable()
                        .frame(width: 64, height: 32)
                        .cornerRadius(8)
                } else {
                    ProgressView()  // Show loading spinner
                }
                VStack(alignment: .leading,spacing:2){
                    Text(medicine.name)
                    .font(
                    Font.custom("SUIT", size: 14)
                    .weight(.medium)
                    )
                    .foregroundColor(medicine.atcCode.score == 2 ?  Color(red: 0.88, green: 0.06, blue: 0.16) : Color(red: 0.08, green: 0.08, blue: 0.08))
                    Text(medicine.effect)
                    .font(
                    Font.custom("SUIT", size: 10)
                    .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.51, green: 0.5, blue: 0.59))
                }
                Spacer()
            }
            .padding(.vertical, 3)
            .onTapGesture {
                isDetailViewPresented = true
            }
            .sheet(isPresented: $isDetailViewPresented) {
                MedicineDetailViewControllerWrapper(medicine: medicine)
            }
            
            if medicine.atcCode.score == 0 {
                Image("Green-Light")
                    .resizable()
                    .frame(width: 16, height: 16)
            } else if medicine.atcCode.score == 1 {
                Image("Yellow-Light") // Change to the appropriate image
                    .resizable()
                    .frame(width: 16, height: 16)
            } else if medicine.atcCode.score == 2 {
                Image("Red-Light")
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            Button(action: {
                medicine.isTaken.toggle()
                print(medicine.isTaken)
                isCompleted = medicine.isTaken
            }) {
                Image(isAllCompleted ? "Check_disable_end" : (medicine.isTaken ? "Check_disable_ing" : "Check_disable"))
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal,16)
        .onAppear {
                 viewModel.fetchDrugInfo(kdCode: medicine.kdCode)
             }
          }
    
}


//MARK: - preview
struct MedicationItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        let medicine = Binding<Medicine>(
            get: {
                Medicine(
                    id: 1,
                    image: "image_덱시로펜정",
                    name: "데크시로펜정",
                    effect: "해열, 진통, 소염제",
                    kdCode: "645900210",
                    atcCode: AtcCode(code: "ATC001", score: 1),
                    count: 10,
                    isTaken: false,
                    isOverLap: false
                )
                
            },
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
