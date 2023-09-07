import SwiftUI
import Combine

struct DirectAddMedicineSwiftUIView: View {
    @State private var keyword: String = ""
    @State private var medicineList: [String] = []
    @State private var isLoading: Bool = false
    private let keywordPublisher = PassthroughSubject<Void, Never>()

    var body: some View {
        VStack {
            TextField("약물 검색", text: $keyword)
                .padding()
                .onReceive(keywordPublisher.debounce(for: 0.5, scheduler: RunLoop.main)) { _ in
                                    searchMedicine()
                                }
                .foregroundColor(.clear)
                .cornerRadius(8)
                .frame(height: 64)
                .overlay(
                RoundedRectangle(cornerRadius: 8)
                .inset(by: 1)
                .stroke(Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 2)
                )


            Button(action: {
                searchMedicine()
            }) {
                Text("검색")
            }
            .padding()
            
            if isLoading {
                ProgressView()
            } else {
                List(medicineList, id: \.self) { medicine in
                    Text(medicine)
                }
            }
        }
        .padding(.horizontal,20)
        .padding(.top,20)
    }
    
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
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON Response: \(jsonResponse)")
                    
                    if let list = jsonResponse["List"] as? [[String: Any]] {
                        self.medicineList = list.compactMap { $0["Name"] as? String }
                        print(self.medicineList)
                    } else {
                        print("Error: 'List' key not found in JSON response")
                    }
                } else {
                    print("Error: Unable to parse JSON response")
                }
            } catch {
                print("JSON Parsing Error: \(error)")
            }
        }
        
        task.resume()
    }

}

struct DirectAddMedicineSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DirectAddMedicineSwiftUIView()
    }
}
