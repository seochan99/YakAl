import SwiftUI

enum Mode {
    case light, regular
}

struct ModeButton: View {
    var mode: Mode
    var title: String
    var description: String


    @Binding var selectedMode: Mode

    var body: some View {
        Button(action: {
            selectedMode = mode
        }) {
            VStack {
                HStack{
                    VStack(alignment: .leading,spacing: 16){
                        Text(title)
                            .font(Font.custom("SUIT", size: 24).weight(.medium))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        Text(description)
                            .font(Font.custom("SUIT", size: 15).weight(.bold))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                            .multilineTextAlignment(.leading) // 왼쪽 정렬

                    }.padding(.horizontal,20)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 20))
            .frame(maxWidth: .infinity)
            .background(selectedMode == mode ? Color(red: 0.95, green: 0.96, blue: 1) : .white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 1)
                    .stroke(selectedMode == mode ? Color(red: 0.33, green: 0.53, blue: 0.99) : Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 2)
            )
        }
    }
}
