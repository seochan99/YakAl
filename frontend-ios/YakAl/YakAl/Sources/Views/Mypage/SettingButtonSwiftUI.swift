//
//  SettingButtonSwiftUI.swift
//  YakAl
//
//  Created by 서희찬 on 2023/08/22.
//

import SwiftUI

//MARK: - SettingButton View
struct SettingButton: View {
    let action: () -> Void
    let imageName: String?
    let title: String

    init(action: @escaping () -> Void, imageName: String?, title: String) {
        self.action = action
        self.imageName = imageName
        self.title = title
    }

    private var destinationView: AnyView {
         switch imageName {
         case "gear":
             return AnyView(SettingSwiftUIView())
         case "icon-line-bell":
             return AnyView(SettingSwiftUIView())
//             return AnyView(NotificationSwiftUIView())
         default:
             return AnyView(EmptyView())  // default view if neither matched
         }
     }
    
    var body: some View {
        NavigationLink(destination: destinationView){
                HStack {
                    if let validImageName = imageName {  // 옵셔널 바인딩을 사용하여 이미지 이름이 nil이 아닌 경우에만 Image를 표시
                        Image(validImageName)
                    }
                    Text(title)
                        .font(Font.custom("SUIT", size: 16).weight(.medium))
                        .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                    Spacer()
                    if imageName == "house-home" {
                        Text("경기 성남시 분당구 불정로 6")
                            .font(Font.custom("SUIT", size: 14).weight(.medium))
                            .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical,15)
                .background(Color(red: 1, green: 1, blue: 1))
        }
    }
}

struct SettingButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingButton(action: {}, imageName: "house-home", title: "내 위치 설정")
    }
}
