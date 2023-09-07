import SwiftUI
import Combine


struct SearchMedicineModel: Identifiable {
    let id = UUID()
    let Name: String
    let Code: String
}

struct DirectAddMedicineSwiftUIView: View {
    @State private var keyword: String = ""
    @State private var kimsCode: String = ""
    @State private var isLoading: Bool = false
    @State private var isEditing: Bool = false
    @State private var medicineList: [SearchMedicineModel] = []
    @State private var showNextPage: Bool = false


    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("약 이름 입력", text: $keyword, onEditingChanged: { editing in
                    self.isEditing = editing
                })
                .padding()
                .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                .cornerRadius(8)
                .frame(height: 64)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 1)
                        .stroke(isEditing ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 2)
                )
                .onChange(of: keyword) { newValue in
                    searchMedicine()
                }
                
                ScrollView(showsIndicators: false){
                    if isLoading {
                        ProgressView()
                    } else {
                        VStack(alignment: .leading, spacing: 30) {
                            if medicineList.isEmpty {
                                if !keyword.isEmpty {
                                    Text("\(keyword) 검색결과 없습니다\n다음을 누르면 입력한 약물이 등록됩니다!")
                                        .font(Font.custom("SUIT", size: 20).weight(.medium))
                                        .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                                        .padding(.top,40)
                                }
                            } else {
                                ForEach(medicineList) { medicine in
                                    Text(medicine.Name)  // Access the 'name' property here
                                        .font(Font.custom("SUIT", size: 14).weight(.medium))
                                        .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding() // Add padding to increase the tappable area
                                        .onTapGesture {
                                            self.keyword = medicine.Name
                                            self.kimsCode = medicine.Code
                                        }
                                }
                                Spacer()
                            }
                        }
                    }
                }
                if(keyword.isEmpty)
                {
                    BlueHorizontalButton(text: "다음", action: {},isEnabled: false)
                        .padding(.bottom,20)
                }else{
                    // 다음버튼
                    NavigationLink(destination: NextPageView(keyword: $keyword,code: $kimsCode)){
                        Text("다음")
                            .font(
                            Font.custom("SUIT", size: 20)
                            .weight(.semibold)
                            )
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)  // Fill the horizontal direction
                            .frame(height: 50)
                            .background(Color("MainColor"))
                            .cornerRadius(10)
                    }
                }

                
            }
            .padding(.horizontal,20)
            .padding(.top,40)
        }
    }
    
  
    
    
//MARK: - API호출
    func searchMedicine() {
        isLoading = true
        medicineList = []
        
        var urlComponents = URLComponents(string: "https://api2.kims.co.kr/api/search/list")
        urlComponents?.queryItems = [
            URLQueryItem(name: "keyword", value: keyword),
            URLQueryItem(name: "mode", value: "1"),
            URLQueryItem(name: "pageNo", value: "1")
        ]
        
        guard let url = urlComponents?.url else {
            isLoading = false
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 인증 정보 추가
        let username = "DIVWPM"
        let password = "DIVWPM"
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: .utf8) else {
            print("Error: Unable to encode login data")
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                   defer { isLoading = false }
                   if let error = error {
                       print("Error: \(error.localizedDescription)")
                       return
                   }
                   
                   guard let data = data else {
                       print("Error: No data received")
                       return
                   }
                   
                   do {
                       if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let list = jsonResponse["List"] as? [[String: Any]] {
                           self.medicineList = list.compactMap { dict in
                               guard let name = dict["Name"] as? String, let code = dict["Code"] as? String else { return nil }
                               return SearchMedicineModel(Name: name, Code: code)
                           }
                           print(self.medicineList)
                       } else {
                           print("Error: 'List' key not found in JSON response or unable to parse JSON response")
                       }
                   } catch {
                       print("JSON Parsing Error: \(error)")
                   }
               }
        
        task.resume()
    }

}

//MARK: - 다음페이지
struct NextPageView: View {
    @Binding var keyword: String
    @Binding var code: String
//    @State private var medicine: DrugInfo? = nil
    @State private var identaImage: Image? = nil
    @State private var selectedDuration = "1일"
    @State private var responseString: String = ""
    @State private var timeSelections: [String: Bool] = ["아침": true, "점심": true, "저녁": true, "기타": false]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let timeSelectionOrder = ["아침", "점심", "저녁", "기타"]
    
    let durations = ["1일", "2일", "3일", "4일", "5일", "6일", "7일", "1주", "2주", "1달", "3달"]

    
    //MARK: - 약정보 불러오기
//    private func fetchDrugInfo() {
//           guard let url = URL(string: "https://api2.kims.co.kr/api/drug/info") else {
//               print("Invalid URL")
//               return
//           }
//
//           var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
//           urlComponents?.queryItems = [
//               URLQueryItem(name: "drugcode", value: code),
//               URLQueryItem(name: "drugtype", value: "K")
//           ]
//
//           var request = URLRequest(url: (urlComponents?.url)!)
//           request.httpMethod = "GET"
//           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//
//
//        // 유저네임, 패스워드
//        let username = "DIVWPM"
//        let password = "DIVWPM"
//        let loginString = "\(username):\(password)"
//
//        if let utf8Data = loginString.data(using: .utf8) {
//            let base64LoginString = utf8Data.base64EncodedString()
//            request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
//        }
//
//
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                do {
//                    let response = try JSONDecoder().decode(DrugInfoResponse.self, from: data)
//
//                     DispatchQueue.main.async {
//                         if  response.DrugInfo != nil {
//                             self.medicine.drugInfo = response.DrugInfo
//                         } else {
//                             print("medicine property is nil")
//                         }
//
//                         let base64String = response.DrugInfo.IdentaImage
//                         if let imageData = Data(base64Encoded: base64String), let uiImage = UIImage(data: imageData) {
//                             let image = Image(uiImage: uiImage)
//                             self.identaImage = image
//                             self.responseString = "Data fetched successfully"
//                         } else {
//                             self.responseString = "Image decoding failed"
//                         }
//                     }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                    DispatchQueue.main.async {
//                        self.responseString = "Error decoding JSON: \(error.localizedDescription)"
//                    }
//                }
//            } else if let error = error {
//                DispatchQueue.main.async {
//                    self.responseString = "Request failed: \(error.localizedDescription)"
//                }
//            }
//        }
//
//
//           task.resume()
//       }
//
    var body: some View {
        VStack(alignment: .leading) {
            Text("복약 기간과 시간을\n설정해주세요")
              .font(
                Font.custom("SUIT", size: 24)
                  .weight(.medium)
              )
              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
              .padding(.top,20)

            Picker("기간 선택", selection: $selectedDuration) {
                ForEach(durations, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            HStack{
                Image("image_덱시로펜정")
                Text("\(keyword)")
                    .padding()
            }
            

            VStack(alignment: .leading) {
                Text("기간 설정 버튼(중복) :")
                    .padding(.bottom, 10)

                ForEach(timeSelectionOrder, id: \.self) { key in
                    if let isOn = timeSelections[key] {
                        Toggle(key, isOn: Binding(
                            get: { isOn },
                            set: { newValue in timeSelections[key] = newValue }
                        ))
                    }
                }
            }
            .padding()
            

            Spacer()
            
            BlueHorizontalButton(text: "완료", action: {
                
                self.presentationMode.wrappedValue.dismiss()
                self.presentationMode.wrappedValue.dismiss()

            }, isEnabled: true)
        }
        .padding(.horizontal,20)
        .navigationTitle("약 추가하기")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                        Text("뒤로")
                            .foregroundColor(Color(UIColor(red: 0.38, green: 0.38, blue: 0.45, alpha: 1)))
                    }
                }
            }
        }
    }
}

struct DirectAddMedicineSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DirectAddMedicineSwiftUIView()
    }
}
