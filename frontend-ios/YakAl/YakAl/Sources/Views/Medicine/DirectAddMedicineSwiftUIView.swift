import SwiftUI
import Combine


struct SearchMedicineModel: Identifiable {
    let id = UUID()
    let Name: String
    let Code: String
}

struct DirectAddMedicineSwiftUIView: View {
    @State private var keyword: String = ""
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
                                    Text("\(keyword) 검색결과 없습니다")
                                        .font(Font.custom("SUIT", size: 14).weight(.medium))
                                        .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
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
                }else{
                    // 다음버튼
                    NavigationLink(destination: NextPageView(keyword: $keyword)){
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

struct NextPageView: View {
    @Binding var keyword: String
    @State private var selectedDuration = "1일"
    @State private var timeSelections: [String: Bool] = ["아침": false, "점심": false, "저녁": false, "기타": false]

    let durations = ["1일", "2일", "3일", "4일", "5일", "6일", "7일", "1주", "2주", "1달", "3달"]

    var body: some View {
        VStack {
            Text("복약 기간과 시간을\n설정해주세요")
              .font(
                Font.custom("SUIT", size: 24)
                  .weight(.medium)
              )
              .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))

            Picker("기간 선택", selection: $selectedDuration) {
                ForEach(durations, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Text("\(keyword)")
                .padding()

            VStack(alignment: .leading) {
                Text("기간 설정 버튼(중복) :")
                    .padding(.bottom, 10)

                ForEach(timeSelections.keys.sorted(), id: \.self) { key in
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
        }
        .padding()
    }
}

struct DirectAddMedicineSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DirectAddMedicineSwiftUIView()
    }
}
