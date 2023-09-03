import SwiftUI

struct OptionButton: View {
    var title: String
    @Binding var selected: String?
    
    var body: some View {
        Button(action: {
            self.selected = self.title
        }) {
            VStack {
                Image(selected == title ? "Check_fill" : "Check_disable")
                                                   .resizable()
                                                   .frame(width: 36, height: 36)
                Text(title)
                    .font(Font.custom("SUIT", size: 14).weight(.medium))
                    .foregroundColor(selected == title ? Color.blue : Color.gray)
            }
        }
    }
}
