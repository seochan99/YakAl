import SwiftUI

extension View {
    func dismissKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct WishYakalSwiftUIView: View {
    @State private var feedback: String = ""
    @State private var placeholderText: String = "특정 주제의 도배글, 내용없는 글쓰기는 자제해주세요."

    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .leading) {
                Text("더 나은 약알을 위해")
                    .font(Font.custom("SUIT", size: 24).weight(.medium))
                    .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                
                HStack{
                    Text("소중한 의견을")
                        .font(Font.custom("SUIT", size: 24).weight(.bold))
                        .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                    
                    Text("남겨주세요!")
                        .font(Font.custom("SUIT", size: 24).weight(.medium))
                        .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                }
                
            }.padding(.horizontal,20)
            
            ZStack {
                if self.feedback.isEmpty {
                        TextEditor(text:$placeholderText)
                            .font(.body)
                            .foregroundColor(.gray)
                            .disabled(true)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .inset(by: 1)
                                    .stroke(Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 2)
                            )
                            .cornerRadius(8)
                            .padding(.vertical, 20)
                            .padding(.horizontal,20)
                            .frame(minHeight: 20, maxHeight: 340)
                }
                TextEditor(text: $feedback)
                    .font(.body)
                    .opacity(self.feedback.isEmpty ? 0.25 : 1)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .inset(by: 1)
                            .stroke(Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 2)
                    )
                    .cornerRadius(8)
                    .padding(.vertical, 20)
                    .padding(.horizontal,20)
                    .frame(minHeight: 20, maxHeight: 340)
            }
        

            // textarea Box
            Spacer()
            BlueHorizontalButton(text:"완료",action: {})

            
        }
            .padding(.top,40)
            .dismissKeyboardOnTap()  // 키보드 닫기 동작 추가

    }
}

struct WishYakal_Previews: PreviewProvider {
    static var previews: some View {
        WishYakalSwiftUIView()
    }
}
