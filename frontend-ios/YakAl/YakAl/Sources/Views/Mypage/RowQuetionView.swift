//
//  RowQuetionView.swift
//  YakAl
//
//  Created by 서희찬 on 2023/09/04.
//

import SwiftUI

//MARK: - 질문 뷰
struct RowQuestionView: View {
    var index: Int
   var question: String
    var options: [String]
    @Binding var selectedOption: String?
    


    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("\(index + 1). \(question)") // 인덱스를 붙여서 표시
                .font(Font.custom("SUIT", size: 15).weight(.medium))
                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
            HStack {
                OptionButton(title: options[0], selected: $selectedOption)
                Spacer()
                OptionButton(title: options[1], selected: $selectedOption)
                Spacer()
                OptionButton(title: options[2], selected: $selectedOption)
                Spacer()
                OptionButton(title: options[3], selected: $selectedOption)
                // if options length가 5일때
                if options.count == 5 {
                       Spacer()
                       OptionButton(title: options[4], selected: $selectedOption)
                   }
            }
        }.frame(maxWidth:.infinity)
            .padding(.horizontal,5)
    }
}

struct RowQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        RowQuestionView(index: 1, question: "Sample Question", options: ["전혀없음", "가끔", "대부분", "항상"],selectedOption: .constant(nil))
    }
}
