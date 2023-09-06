import SwiftUI

struct MedicineDetailView: View {
    @Binding var medicine: Medicine
    
    var body: some View {
        ScrollView(showsIndicators: false){
            // 약물 설명
            VStack(spacing: 5){
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top,spacing:18){
                        // Convert base64 string to Image and display it
                        if let base64String = medicine.drugInfo?.IdentaImage,
                           let imageData = Data(base64Encoded: base64String),
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 96, height: 48)
                                .cornerRadius(8)
                        }
                        // 약물 설명
                        VStack(alignment: .leading){
                            Text(medicine.name)
                                .font(
                                    Font.custom("SUIT", size: 16)
                                        .weight(.bold)
                                )
                                .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                            
                            Text("방광 & 전립선질환 치료제. 혹시나 두줄일 경우 행간 22px")
                                .font(
                                    Font.custom("SUIT", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))
                                .frame(width: 228, alignment: .bottomLeading)
                        }
                    }
                    // 복약 정보, 음식/약물, 금기, 신중 투여 tab bar 누르면 해당페이지로 이동함
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20) // Side padding
                .padding(.vertical, 20) // Vertical padding
                //            .background(Color(red: 0.96, green: 0.96, blue: 0.98)) // Background color
                
                
                
//MARK: - 이러한 약물이에요!
                VStack(alignment: .leading, spacing: 10){
                    PillDetailComponent(imageName: "icon-detail-pill-blue", text: "이러한 약물이에요!")
                    Text(medicine.drugInfo?.BriefIndication ?? "준비중 입니다!")
                        .font(
                            Font.custom("SUIT", size: 15)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        .frame(width: 340, alignment: .topLeading)
                }
                .padding(.horizontal, 20) // Side padding
                .padding(.vertical, 20) // Vertical padding
                .background(.white)
                
                
//MARK: - 복약 정보
                VStack(alignment: .leading, spacing: 10){
                    PillDetailComponent(imageName: "icon-detail-pill-gray", text: "복약 정보")
                    Text(medicine.drugInfo?.BriefMono.replacingOccurrences(of: "<br>", with: "") ?? "준비중 입니다!")
                        .font(
                            Font.custom("SUIT", size: 15)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        .lineSpacing(7) // Adjust line spacing as needed
                    HStack{
                        VStack {
                              ScrollView(.horizontal, showsIndicators: false) {
                                  HStack(spacing: 10) {
                                      ForEach(medicine.drugInfo?.Pictogram ?? [], id: \.self) { pictogram in
                                          if let imageData = Data(base64Encoded: pictogram.Image),
                                             let uiImage = UIImage(data: imageData) {
                                              VStack{
                                                  Image(uiImage: uiImage)
                                                      .resizable()
                                                      .frame(width: 80, height: 112)
                                                      .cornerRadius(8)
                                                  }
                                              }
                                          }
                                      }
                                  }
                                  .padding()
                              }
                    }
                }.padding(.horizontal, 20) // Side padding
                .padding(.vertical, 20) // Vertical padding
                .background(.white)
                
                
                // div처리 알고리즘
                VStack(alignment: .leading, spacing: 10) {
                    PillDetailComponent(imageName: "icon-detail-food", text: "이런 음식/약물은 조심해요")
                    
                    let interactionText = medicine.drugInfo?.Interaction ?? "준비중 입니다!"
                    
                    let styledText = interactionText
                        .replacingOccurrences(of: "<div style=\"margin-left:20px\">", with: "")
                        .replacingOccurrences(of: "<br>", with: "")
                        .replacingOccurrences(of: "</div>", with: "\n")
                    
                    if let range = styledText.range(of: "<div>(.*?)</div>", options: .regularExpression, range: nil, locale: nil) {
                        Text(styledText[..<range.lowerBound])
                            .font(Font.custom("SUIT", size: 15).weight(.medium))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                            .frame(width: 340, alignment: .topLeading)
                        
                        Text(styledText[range])
                            .font(Font.custom("SUIT", size: 15).weight(.medium))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                            .frame(width: 340, alignment: .topLeading)
                            .padding(.leading, 20) // Add padding for the div content
                        
                        if range.upperBound < styledText.endIndex {
                            Text(styledText[range.upperBound...])
                                .font(Font.custom("SUIT", size: 15).weight(.medium))
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                                .frame(width: 340, alignment: .topLeading)
                        }
                    } else {
                        Text(styledText)
                            .font(Font.custom("SUIT", size: 15).weight(.medium))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                            .frame(width: 340, alignment: .topLeading)
                    }
                }
                .padding(.horizontal, 20) // Side padding
                .padding(.vertical, 20) // Vertical padding
                .background(.white)
                
                // 방광근을
                VStack(alignment: .leading, spacing: 10){
                    PillDetailComponent(imageName: "icon-detail-pill-blue", text: "이러한 약물이에요!")
                    Text("방광근을 이완시켜 빈뇨, 요실금 등을 치료합니다. 두 줄일 경우 행간 24px")
                        .font(
                            Font.custom("SUIT", size: 15)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        .frame(width: 340, alignment: .topLeading)
                    
                    
                    
                }.padding(.horizontal, 20) // Side padding
                    .padding(.vertical, 20) // Vertical padding
                    .background(.white)
                
                // 방광근을
                VStack(alignment: .leading, spacing: 10){
                    PillDetailComponent(imageName: "icon-detail-pill-blue", text: "이러한 약물이에요!")
                    Text("방광근을 이완시켜 빈뇨, 요실금 등을 치료합니다. 두 줄일 경우 행간 24px")
                        .font(
                            Font.custom("SUIT", size: 15)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                        .frame(width: 340, alignment: .topLeading)
                    
                    
                    
                }.padding(.horizontal, 20) // Side padding
                    .padding(.vertical, 20) // Vertical padding
                    .background(.white)
                
                
                
                
            }.background(Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1))
            
        }
    }
}

//MARK: - 약물 디테일
struct PillDetailComponent: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(imageName)
                .frame(width: 24, height: 24, alignment: .leading)
            Text(text)
                .font(
                    Font.custom("SUIT", size: 16)
                        .weight(.bold)
                )
                .foregroundColor(Color(red: 0.08, green: 0.08, blue: 0.08))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MedicineDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let medicine = Binding.constant(
            Medicine(
                id: 1,
                image: "image_덱시로펜정",
                name: "데크시로펜정",
                effect: "해열, 진통, 소염제",
                kdCode: "645900210",
                atcCode: AtcCode(code: "ATC001", score: 1),
                count: 10,
                isTaken: false,
                isOverLap: false,
                drugInfo: DrugInfo(IdentaImage: "R0lGODlhyABUAIcAANainOqcluWVjtmSieKNgvqppOqalOCRidbW1s7Ozry8vO2alLKysu6gmvGclZSUlODg4N6NhcjIyNiblPCemMHBwcaDesx7cvamofGhnKKiouSZksqqqOyZkvmmoeWWkJubm/Ggmqurq9SopM3R0cealtXU1OisqISEhMO7u7SrrOiWjuyclrl6cemWkKxjVMbGxruztOqemMXJyoyMjO6emLttYMF8dO6clrJ0a/SincR0aquamdOLguSRieKQhtiJgNLV1alzaNWFfbpqW8mJgrNjVO6cmKt7c+OHfNGBecLExsjNzqqEfOGPiPSjntTW1ranqOqYktHQ0LGio+iYkOmakuKTi7l1ba2kpbiameKUjvWgmOqXjr15cd2Mg+yemLyjoqtqXMG0tPaoo+ucmMrKyuyclNmGftGFfauMh9awrfijn++fmtqJf8l4b+Xl5eqYkMJxZtyKgeqQhdbY2LRmWL7AwbRqXOSTjKltYuiYktWIfuyelueNguaknfGknriusL2ur+mUi+2bmOebk+Li4tuNhLp4btWGgM6RiuWTi+2XjdSCet6Ph8h2bLxwZdB+dsTHyNja2rm3uLW6u8DCxLyHgadgUb2+vu6blKpmV++eltqLgsm0stKDfM/S0718dLp7csuxrq2foKZeUL96c+ySiMrOz7R4brp6dOKUism5urd5cc1/d+aYjr58c9WFe69xZcPDw+6bk+eUjeqckqZmWdXU0++cmuyUin5+ftWDftDT09HR0e2dmdOEfLdmVtvb29PT09PS0tbV1dTT09rZ2dra2tLS0tva2tzb29fX19jY18zLy9rb29vb2tzc28fHx9bW1dvc3M/Pz9na2uuakdPT0qphT9vc29DQz9PS0+mgmPGZkNvb3L+AePSkmsPExMfLzNOAd9mKg9+Lg9XX19DP0LuopuyelNnZ2a2TkNzb3Nra2embktGzs8V4cL2RjsStrrV2b7t4cNLT0rp+dr9vY9XV1djY2Nzc3N/f39DQ0N7e3t3d3SH/C05FVFNDQVBFMi4wAwEBAAAh+QQAAAAAACwAAAAAyABUAAAI/wBN8PNHsKDBgwT/IRiIsGHBfRIYOmyoUOLEgxAtXixYcSPCjB4Pdgz5MCJJjgtPFqy2Tp/LlzBjumTmq6XMmy8RzLKJ8yZNnj1j6gQa9OXPojKHIo15dGnOnU6N1oz6kiVVfU2jKqWa1enWqF2XfnUaFunYpWWRClTpb+RJkCrdkoR7Um5IuiTtesQbUq/HYW3/Cf4XeLBhwfvyFT5MmPE/YRIWOxZcOLHkyYapRcY82XJjzoYhS7582PNk0qJBUx5sWrVhwIP9LVNGmrVix7JpM07NOXfg1qr97dO32bVt38Z5E55dG/FtxsgPKz/N3Hlz6MuEwRYsjJgJYZyBD//u/n13cczkwf8Tz7k7MRjXHSfe5129auXpwz+XXt98/Pzr7XcfMfnAts86xDBDDALNiXdgggtKNl1pCCrIYIDxIVbhFBXwY9xg0fRjjIUZPhbRehVGiJmDKV4Y2nmMPUgihq7JaMwwBw5jTDLFrAOaacKtoyOPPvoHXY479nhcb0jyyIw0JRL2oDPEKJmcBP8ImWSRKz4X5JBWSgcjZU2GyZ5hX26ZgD4m6OhjfKYd00ybxrzp2IT/yEmnndZxpqeb642JmZ7EOHPMZ64Js9OeiHb23J91NjqeoJDySeOgcwLqjzQmFIOApI4SRF+nnzY3nXDeeSrpmVKmWqqJGaL/2mkxJkRJGTKZFKNqiZbJuit6MPr6qmGsCvuZofbVeJs/zKyT7GQTMutsqJhJmyyeuDULnoA1VqDMsz8uq+19Y1pL7WnjvmZrnx/C2u6lH2Kr37rutssqsPTei9l2H+p7p6Dh0itvlwIDPO+7A5/bLr/G+WukvdySm2/EoCUsH8XtGUzwu/8wrGzBE4P8rsNihoywxgp/6LFqJL9ocrsWx4gxviPPDC3KF9Pb8cvx4iyzyBAD3a/N//KsstGJ+lwa0Q8PLXTDTJdcs84rB3wy0hJPfbXWMCtNbNSH5QMBP2SXbfbZZDM7Ntpsl/2PGWu3zbbacrf9dtx1m0133mff/8332Xv/TbbfgqfNDN6Cw+BLP4z3U00CjUceeTUSLC45449f3k8CCliueeOZY175559X40znpJdeeeipN865545DnjrlsE8uu+Svtx476KPrDnoCirsOgwS3a0675sATf3nuqScv+/G+bw4DDKhHL3o1wxfffPXSK0869Lhnvzz3nzsveu3NDy/2QNDks44J+iCu9+GAt/9+/H3DDcH+/PPPzzLFOIYJ1rE/fsSvf3Lzh/2SIQ755c0fRIKfA9HmNwW6T4JsK+ABEQjA9xGwfxDwB9wSaD8MBq5uFlxHMXCkJSJZTUotDBNh2iIMafwDGdbIYQ6foQ8EYM4eCLAGDv/XkYxnWOMZwtgHZQKTJidByThBKlSVuESuLIGJSxxBjDCQgSNhJNEdNFkcLpjhxTJ60RpPzGITzWSzNa5jTYyC06MyFanCUGMdQSDBDBggiVlU4I9/zIQCKEFIBQAykJTwYwXEMQMmkAAK1hAMMujoI4hEiVCGAhV6FqWphDyjDr1AxThmIAlJLCETS0ilJe6ggEoo4A6pjKUsl8AAJqACFOd4hiQpiSh9VYownPoVyxRjrMLUgQSSSIEnOMABADjzmc6cQAkmMIFoWvOZ1XQmB+YxhgowIQhTMAECXhUzX9FqXf7Ala6GRY1zoEIcKRgFB0ZAzxFAEwAlKAE+78n/z31us5uogIIvTDCNYS0JN6MSJrKCRph0CWYdqKjAKEbwh270QQbdsCgYaiCDBoBhAxsoREa7wYJCBEAGYGCBOgxQiJaCFKTSjMESkoGMwsSsodMCG2u8ZZ99QGEGKWjmH/rQh27IIABnkIFSURrSAIAhowEIgAGiGtWWWiEAhQDpFiYQhhRI4jukuZe51MW10gRhFqP4QzgawFYwLDWjb13qUat6UqWaFKstfcdLB9CDElCCBPa56deEpgxUpICi4cgAW+UKV7nWda5RVWoA3lHVQlghqxvYAl/DUIEgKPFnHKvawaRDghT8AQOASG0DarDak7pVqW4Fwy8gWwYw/0S1DGUwgC3OEIAyTDYAWj0AH4qQDlQggzteO2jPArOOGYwCEBjQASAy0AbW2najrz0qC2YbgD7gdq64NQBloype4G5gFYfggyJiQILPDja0SBMGEzxBBg88QbqKbYN+a8CC/v6Cv2X4bw3A8I4zgMG2BtguC6i6YCuwtAoCOIAjgGCBMDBBGfVy2sk8tA5JrAEDGHjCEwDB1v3yt799+MUvtluDX5TBCupw62RZUIYF2zgAV7XCB7bgiEOkoQgx6IV72bUwo+0DFfQlQ4jv24AQhKC61cUBDiig3yMouAY1CMAvztBiGvc3y1Q1gAFeIYArHKAcaXBFOtorWOVeif8fyPAwGQqw5Aw4uQEUqEEbKIADPVf3CP9lwYkXfOIAsCClvQ3zK/JwBUf0QAkWoMSn3vsu0W5sMCRgxZxBrIMMeNrJeS6xn6uL5V9UV8X93e4vDF0D3IYZwls4QHqV4ApBBKHNRL7SP8YBjwLQGQOfBjUFKFDiPZ8ay6r+hZVV7dv+GpqqOi5zj/lwgSJYgootIytDBVOHCpzA1x7AABs67ek2OCAEFAgBnjmRCxz8QhN9XkAHHFADCgh6xTWwQhcY0QFaNHgPH4jwhJVwgUuIgzhYq5gEgpACX9c3xDoIgWIp4IBhr3bPfFZxlKdMAU6omBC4XTELFnAGFhjACgD/z4OE+eCKR2ihvW42jqXPtQ8mrAHcHrCvDjqtbl2cgg6nOIU3dFBvHPwA6EGngze4QIEVB+AHSfCDLpTOiQBIYQN7kHYnCL6DMPRCGh7adr9gIIlvFyDn4945des97GFzot6AroGUaaGJXAwbByw4AslTzYI+B6AKH9jxyiPxBlgoYB2/0elgZp4zwnR7zgVggwfYIGIdULkGSWAELWjBCD84QAe5OAMBGBECTuDgHX5gRAZwQAgCJCHPUT3DGU7+ij1sodHlAMYFdnCJJcAg7Bq21x1YAW7JU/4JXKguIaaMZU6gGwcLIEQNzoAD00uZEyzQhPYXcGowyN4AVQC8/5kjAAQlvGEHWuhFzF3jMTkGhgS9PjvaKR/xI3QgCWwwdhf8wPQO+GHop+YDp6ADhLACScAFGcBfveVbVlAFK3AFuKd7O7ADgWAJwAc1bWErz0AJNyd/k0d/Tdd3CyBlNcAJFLB5gBYANXAEFHAEJWh9HcAJp3YGvnVyEAaBh1B+jyAHlyAJ2tAW2bZ4hREd1LIPM2B2H6gD9PdkccB/d+d//UcA3vAEqEYAdKADv+AD5hAObeB0UWUFUrACi2BmjtAJsXB+NsAOd3CBH1MdwbEODICEbDBu45Z8fFZ6RwBvmkALFABvpaZiqxYAJqgJ3JdnviVVBtAFg8BosqaDcv8ACTEwCUCoU7KhHTbVHwTjD4oih9J3X1zAhPwXZQvAfxnQAaPnAB3QBT+ABgKgZ1DHdJowVZNVBS4wCLVAhuXwCW8gB0SABAwwMaMCLrgBBSrga2fHBgbQBjuXfOjmZDUAb1Lmdn0QAMNGCISwBQIQAPC2eZwQi19Ii7XAaI5Afq6wA/hgBzzQC5NoK91RIEDYIg1CTHWQApD3BG2QAR3FBuiWC1XAfyHgblbghAtAAH4AdH5AACsAUjVQCweYCwuwAOVlAFJQBXmwCuNYfvFgA0QgBCKwD+sSIiOiIqDhD70QBeD2BA2Ajw2AfFSGbhRXbw6QC++2bEdwBAaQBzv/tgdnQIi04AAQKWYnJwUCsAoSll7laAN2oAbjsI41UiHGYAJ5Ygw3ggA1dREVwQ91QHwYkAtt0ACpBXHUtQKhmAs1UAV0EA4UEACZhwNbEHgfMFUssAKjFwL2J2Z/twK2V5RpJgdIKQZZ8A0aMRH7gAzY4AzGQJUkwQ8kwAF0xpVeCV33lYBtZ4Idl2fXsADvZgA7ho1waQBnQAvy1gGyuALi9wNlmAbxAAl4YARNwAQJkRIXsQ/HIJXDQJVmMAzokAAJAD9EIRM/sQ4kMAZPoFgZgAG+FmJ2RgEucID2xgIEMAiAgANSMAddYABbsAUGsAALJmYCkHrXIAU+MAhx/7kCYugEnQAErpCakEAEeAACA7QUBZKbnKIPvYkT6zAOYcAGxFmPw4lxfAZv6FZ1UbUHAHed2blgAUAIHdAB11ByLHAGYbgCH/ADEdAJLLcD6xkMSGAJzZIWLxGfusmbs4AOvuAL9IkWNbEOvhAIKfkExkhnwzls9/dzdAB0DtCNBoAGP6BjBoADlxmLBnANcukHROoALDCRAvADP5AGafYIO6CR6NgL9QkT68AMCVANJdoPU2qf46AFnuaixihiz8cJnEB3uaB3uWCNAXAAgScAPdoBEBkACxAHDaoJ13ANDuaAi+ADEZAGn7B7O0AEGnoHHToVN1GlV1qiJ6oPzv+gDB5ZFwvBD9aQAtB1dsYIYvZYAwYwCLrQqaQnZSO4Cu9QBoRIiA/ZAZogBQYQByvACA9pACtQCz5wAE7AB8AQCbsnqHagAXUQmA2hD8egRLCZmFBABZXqAZd6X12oCd24AEewfEeAA5pwBh8gVYQ4cqHZAXTaAfymqlZQC7VwAAdgDnxAcG+AD8FgBKkgCfvgIcP6q8F6EIz3M/7wDLNwApP3oiDmadHadL8AfXhXAw9JCCxACFIgBdcgkQbQAVLAsOC3oGEoAALgA07wBUAQC5HwCOhqBGJACpIodq7hD+egAvXFBsaoZE8gcTjwmTiQCyN3BO0WiyzQBgtwsNf/8A4Na7NxEAcIGwcuILETGwFzgAaNkKvpigSSEA3CoXiCMa9LA4QzsAaTh6wFgLJ2tmJ7ZwD+5o3Zqaqq+pBV0LBd4LOwGn6AJ4Z8OgdA8Kd8aQR2IAtZ8LHBB0XWEIdzSLVW24Us4G8mdwYPSXJW0F81m53gJ7Y8awUr8ApCGat54ATmMAeJoAQaSwRGYARqwAS5JnMm4w/wd7fGCF2AoLdx+gtixrDfqbA8+52Iy6ouEH7gR5oCsKcR8AVugAaEhw+UawdCwACadGkfog2VAA9ziAFzRgYiloArdnJapqqiCbESmboHS5ph64ACQJ4CkAeLQKFDW7SPgJSVyw7q/wcvR6M1/jCPf0B5ZKBkqJUBpMsCDXhVK9CAUsCze2AArUuaE7kCLlALLkCeEFZm1xsBs4sG5LB7NpCuL9AElZBw4WEJlKoDT5C++9oAzva+exC/XSAFLiAFeyAFtXDBG6y/tUCeKxC7sXsFERYB5uAGjUB4vGgEL7AJgVAHTFlpL7MP4zACTgZd+/oLhACG4UegtKjB+kuLeVDCtdAFsboIi0CeTOwDi8BoTqDCROvClLsJL0AKFlhWDQMDM6DDGcDDGBACNWCwUtCAexB+pNm/K+DB1SsAgxCrshrHsbunt3gAAuwGQ1DAGhsML/ACQmAJwlDDRVZWUGBaeBYCqP+1Z39HvQBXwhK6CNW7p4tQCxLLxFF8BavgA4zGaAL8BWgwBEVrjjAMyHfwe1ycNEHgCX+AZ8UJCFj2utULYRD2AUxcvZx8y7LqA7IKgZwMgVMstEOAsTtIBH+cDeC7fqrhtJS2HuPAAd1QBi7YBu0GeAH3AYu2CquQB4zmAxSbB97szU5AsY4grrTqBBL2uHocCxfQxzGcDaQACmCXylUkCSPQDQlWby4LeBILYdxckVtAsd4Mzj7wA05w0FOMzo7wAxImtOe5x7tIuX8sBJmAeJnLfjwjsikAAFklZoSwAAEnsVvAaBB4AFdw0FcwqwYdAQRgDipsDgQQAeM4u53/MAflUMXnagfvjLQIR88Kxw8MBwAgpaqEoJlA280lfc6zmtBT7NLm8NQyPbtfMAcPzccS/QKYQAXhe9HLPBovhBj9MAbUhI0b/AHcbGZmJq7lbNIHjcefPLss7dJSfQid4AYXi6tyEMO3kA16QAl10A7J1SfsGBFHNg8bMAFkLZS3J65kyNjiGgENLcAu/QUUKsBzPQe1S2tv4Me3sAmloAaoMMjKDBr8QoSNFxrjMA8TMAADQKsnPcUmLWHorHKmicdTXdNfENXB/AWdQLtA0MJvAAl2sAmbgAl6wAC3tg6BjSFumDXIMAOqzdrnPNNq7QjofAUUat1TTdVucAi6/x0BhxDedg3RO4AHxP0Cnz0DyLAPuiG+I5kd/AIgKUMYzRUFijAAitADPTAEiTAE5VAOQzAEQDDgQ8ALiZAIvNAISgAMruAKwAAEAV7gjTAESkBrqYkHYiAGxS0ElBAEykAM7wGMmJg1/tBh9o3fPcCkTAoEidAIn9DfwPAJMs4LtKYEaXABrvAJwKDgn1Dhn+AKkRAPWGADGS4GmHALPDAO67AMmJht7Wgg8Oi7GrINkqACJZDfRVAEFgAOFnADXu7lphDmX24KXoAF9WDmYC7mZI4IOSALbm7kt6AGlgAF+jAMzMAhbKgaIDkj5OIhB0LlKiAPWG4BW/7lsHDoXv8QCrAQ5mF+5q1AD1hgCqHgBV6A6Gfu5rKgB8SNBCqACuuwDtgwIyRjIyx0RS+UJtxgDCRgCelQAlq+5aEQ66KgCqJQ67b+6DmQA6mQCrbe66LQCqnQ5nqQ4U2gAkxgAsRgDFXyJFESRVQiQwpnRcbADbjQD0sgCK5O6DcQ66Ew67Xe7bTeCrmu67zeAr7eAsD+5mKABDxgCUHADFLpQlwdG2XyRmyiKS9UKQSxDqCwBDEQBvJwCeAw6YggCvXgBfWACFhAD+OOBYjgBYgQ8YhQDwmv8OOOBOwQCDMACsVQIJFiScaBSYfCjpxUJwSBDL0wA5SQDgF/CfdQ67SuCqrmgO7inuv00AI43wotEPM5nwpIgARqEAWWAArTwAwebym+xEubQiq9+7TFZBjIcA56lAkxQApRcPVYHwWkQApUQAVZn/Ven/WBQAlLQAJ1gAzeUVCNUU4JdU7tkk65IkxAqA+9wARLoAAxEAOBEAgqsPeBkAVZcPV+P/iDrwJZEAMKsAQB5UVpb1Dz/vT/sFAaNlaHkRDRgAwIcAfnEASc3/mo0A+90Pmiz/lMAAWdDwV1YA3gQRAOlWG9MS5Muw88dRrcYQ3rUAfnAAUJgPvnAPpBAAXnEPzCP/ybbwmToPpL1PrNDB3/yi82E9Q2J/T8/LA/IgRC/mP9/rNBIHQ2eEM4ghNC9FM4HqI/ebP92o/92F/9BcT90B/+dYM40oA+rQM+0cM81kP/vmP/0YP/uqP/ANFP4ECCA6tJ8FVQocIEChIuhNjv4MOIC2FQrEhwYkaGDjkW3PhxYEOMH0OK7EcSpcCTIlWubCkyHwR+NW3exFnTHzOaOX3a/Gem50+fO4cSxRn0KFKbRpnmVPoUp1OpQIVWbcoTq81h/v59BRtW7Nd9+byORQtWmISzadGWbetW7Nq4csHCtTuWbl6xePmqZfv3rlnBYLsW/udX8N7Civ8yFuyYL+S/kvNS5ms57+HGhAtj/86rWS5ou6LdkpZrOi1qt6rTco7seXHgznUv045t2y7rtK714q4sWzDsr7rDmtbNG2xb32KpAc9M2DhazNPJChebHHpa5tj5wva3TJl1zeHH/7b+z/zZ5sX36dte2qz49IDbrk/tXT199HbxJ9aPu2WEgU0YYkwQJr/kiCmGH0MMgcC+3Q5MEMD61CKGGBguPC6ffSh8DDcDEVSQOhDnii+sESts7x8D8+EMGWKYMYEZf/jx6sbl/CGMH5r8eQ8bZJxhgBIGYDCEHxdTTGydGYlBwKvm9nGSmSkqULKwaPoxhhkoL1xLSSqfjLI17Mb0skwVmUTzSwszq9KYYfY5Jv8lYvQZZh1+hkGGHxqV9GedZBDwMR8zkiHQmGkYAIEGEBiggZJ8+AENyHWGMSaZYtYZzDpLMdWUGWk4tJQYZxjkNMR/Ls10U/nO+rTVVFG0LVZNZ1XN1k0T0EcfER7YJxkaGBAmUjh+FcbHX4fhB1IUUMgiCAQqEEGDBzQAQQMaRFjStmOaMQFTTruz7ttwjeF0HybFMtfUY9RbbJZ1zh331a/MFRfe/tgFN19y5cIXXfWkQdDaZB6goZpkUBCBHxBQqACOfGhAwYx+UNBAmmoRYAaELDTQwBcQiBRBH3XjAvLAYhDQt1PuPjRhZXiVUw/mYooxgcPikMnkZpYvhCv/5Zh/Pg04oWWuS7Sjif7HmWMgEIGGB1DIBI6LGUCGYg3goOTZCnxB4QERFMjHEF8euIMBjKXOwkh+oNtpnQrHQo4Zude8MO4EA2ytAmXmji5HuwFfDe7Be+Nbb7G6MkQEFGigQQNDFmbAGUdpkOABhBmAQ4Gpw87HngeyBQEGkEdnAIJ13+K7cJ2ve71bxFr8iua+Wn/Nn8ZRgCETFMTJBwUG7kBBGoQhzlafSf+hZJc7nNFABCMZtjxS1WOnXfbaELO9w9i7dxkxxrOgwR9/NE+A4aj9YWAXEAyx1nENKHlYgsY1vxZbBh5wxp/V6cbdvnLDvf/d7nsF9B5i/tEV/whQQgP7MAQMQNAPECiAAVkwhOgU0DkQ5ONXUlOAjzJ3rUwYr4IQAB/sCIi9ANJqdi3E2wtjt8AcwQtQ+yDLP/ixDimZAAIozMc/IqTDBDzKWiCgRJ9S+KbPIDB8s2HhAaOowGQkhiz7wCEO77IPKZXFil3EIQQQ4IxZVKBsiUGGNBKDRTa20Y1YFIYJ1vhGOmIxjXOs4xvjiMc8tvGOfaTjHgH5xj8Oso2CNGQbnZEPRjbSkY9spAkSAElHcmwd60BAI4dRgUxS0pP5kOQnP7nJTorykaE0JSRJmcpTTpKVjlzlKxmJSlkyklnmw2UudYnLf0xql7/MpbpwBExg9iFymMTcpTCR+UtjLjOZEjimM83XTGniUpnVnKYvsWm+gAAAOw==", Pictogram: [Pictogram(Image: "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", Description: "이 약은 음식물과 함께 복용합니다."),], BriefMonoContraIndication: "위장관궤양이 있거나 징후가 있는 자, 또는 그 재발 기왕력자, <br>\r\n위장관이나 뇌혈관 또는 다른 부위의 출혈, <br>\r\n심한 혈액이상, <br>\r\n심한 간·신장애, <br>\r\n심한 심부전, <br>\r\n심한 고혈압, <br>\r\n본제 및 본제 구성성분 과민반응, <br>\r\n기관지 천식 또는 그 기왕력자, <br>\r\n아스피린이나 타 NSAIDs에 대하여 천식·두드러기·알러지 반응 기왕력자, <br>\r\n관상동맥 우회로술 전후에 발생하는 통증 치료, <br>\r\n임신 6개월 이상 임부, <br>\r\n염증성장질환(크론병 또는 궤양성대장염 등), <br>\r\n이전 NSAIDs 치료로 인한 위장관 출혈 또는 천공 발생 기왕력자.", BriefMonoSpecialPrecaution: "혈액학적 이상 또는 그 기왕력자, <br>\r\n출혈경향이 있는 자, <br>\r\n간·신장애 또는 그 기왕력자, <br>\r\n체액저류 또는 심부전, <br>\r\n고혈압, <br>\r\n과민반응의 기왕력자, <br>\r\n전신홍반루프스(SLE) 및 혼합결합조직병(MCTD), <br>\r\n고령자, 6세 이상, <br>\r\n위암, <br>\r\n알코올중독, <br>\r\n임신 초기·중기의 임부, 임신 계획하는 여성, 가임부, <br>\r\n허혈심장병, 말초동맥질환, 뇌혈관 질환자, <br>\r\n심혈관 질환의 위험인자가 있는 자(고혈압, 고지혈증, 당뇨병, 흡연 등), <br>\r\n간성 포르피린증, <br>\r\n혈액부족을 초래한 중대한 외과수술을 받은 자, <br>\r\n이뇨제 또는 ACE 억제제를 투여 중인 자, <br>\r\n혈액응고장애 또는 항응고제를 투여중인 자, <br>\r\n과거 NSAIDs 장기투여로 인한 소화관 궤양이 있는 자로서, 본제 장기투여가 필요하여 미소프로스톨 등으로 소화성궤양 치료를 병행하는 자, <br>\r\n다음의 약물을 복용중인 자: 코르티코스테로이드, 알코올, 디곡신, 페니토인, 프로베네시드, 설핀피라존, 설포닐우레아제, ACE 억제제 또는 안지오텐신Ⅱ 수용체 길항제, 이뇨제, 리튬, 쿠마린계 항응고제(와르파린 등), 바클로펜, 면역억제제(시클로스포린, 타크로리무스, 시롤리무스), 혈전용해제, 티클로피딘, 항혈전제, 혈중 칼륨농도를 증가시키는 약물(칼륨 저류형 이뇨제, ACE 억제제, 안지오텐신-Ⅱ 수용체 길항제, 시클로스포린과 타크로리무스와 같은 면역억제제, 트리메토프림, 헤파린 등), CYP2C8, CYP2C9의 유도제(리팜피신, 페노바르비탈 등), 저용량(15 mg/주 미만)의 메토트렉세이트 , 항혈소판제 및 선택적 세로토닌 재흡수 억제제(SSRI), 저용량 아스피린 복용자.", BriefMono: "1. 위장장애를 줄이기 위해 식사와 함께 복용하는 것이 좋습니다. <br>\r\n2. 이 약 사용중에 음주는 삼가며, 다른 소염진통제 복용은 피하는 것이 바람직합니다. <br>\r\n3. 어지러움, 졸음이 나타날 수 있으므로 주의를 요하는 작업이나 자동차/기계의 작동시 주의합니다. <br>\r\n4. 알레르기 반응, 두통, 출혈 등 이 약 복용 전에 없던 증상이 나타나면 의사, 약사에게 알립니다.", BriefIndication: "비스테로이드성 소염진통제로서 열을 내리고 염증 및 통증을 치료합니다.",Interaction: "1. 다음 약을 복용하고 있다면 의사나 약사에게 미리 알립니다 .<br>\r\n<div style=\"margin-left:20px\">\r\n- 다른 비스테로이드성 소염진통제(아스피린 등)<br>\r\n- 면역 억제제, 스테로이드제, 메토트렉세이트<br>\r\n- 리튬제제, 디곡신, 페니토인 <br>\r\n- 고혈압 치료제, 이뇨제, 설포닐우레아계열 당뇨병 치료제 <br>\r\n- 항응고제<br></div>\r\n2. 이 약 사용 중에 술을 마실 경우 위장관 부작용이 심해질 수 있으므로 삼가도록 합니다.")
                
            )
        )
        
        return MedicineDetailView(medicine: medicine)
    }
}
