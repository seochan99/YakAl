import SwiftUI

struct MedicineDetailView: View {
    @Binding var medicine: Medicine
    @State private var selectedTab: Int = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            //MARK: - title
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
                            
                            Text(medicine.drugInfo?.BriefIndication ?? "준비중 입니다!")
                                .font(
                                    Font.custom("SUIT", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.56, green: 0.56, blue: 0.62))
                                .frame(width: 228, alignment: .bottomLeading)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20) // Side padding
                .padding(.vertical, 20) // Vertical padding
                //            .background(Color(red: 0.96, green: 0.96, blue: 0.98)) // Background color
                // 복약 정보, 음식/약물, 금기, 신중 투여 tab bar 누르면 해당페이지로 이동함
                Picker(selection: $selectedTab, label: Text("Information Tabs")) {
                    Text("복약 정보").tag(0)
                    Text("음식/약물").tag(1)
                    Text("금기").tag(2)
                    Text("신중 투여").tag(3)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                
                Group {
                    if selectedTab == 0 {
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
                        
                        
                        //MARK: - 이런 음식/약물은 조심해요
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
                        
                        //MARK: - 절대 복용 금지에요
                        VStack(alignment: .leading, spacing: 10){
                            PillDetailComponent(imageName: "icon-detail-block", text: "절대 복용 금지에요")
                            let interactionText2 = medicine.drugInfo?.BriefMonoContraIndication ?? "준비중 입니다!"
                            let styledText = interactionText2
                                .replacingOccurrences(of: "<br>", with: "")
                            Text(styledText)
                                .font(
                                    Font.custom("SUIT", size: 15)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                                .frame(width: 340, alignment: .topLeading)
                            
                            
                            
                        }.padding(.horizontal, 20) // Side padding
                            .padding(.vertical, 20) // Vertical padding
                            .background(.white)
                        //MARK: - 신중한 복용
                        VStack(alignment: .leading, spacing: 10){
                            let interactionText3 = medicine.drugInfo?.BriefMonoSpecialPrecaution ?? "준비중 입니다!"
                            let styledText = interactionText3
                                .replacingOccurrences(of: "<br>", with: "")
                            PillDetailComponent(imageName: "icon-detail-caution", text: "신중한 복용이 필요해요!")
                            Text(styledText)
                                .font(
                                    Font.custom("SUIT", size: 15)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                                .frame(width: 340, alignment: .topLeading)
                        }.padding(.horizontal, 20) // Side padding
                            .padding(.vertical, 20) // Vertical padding
                            .background(.white)
                    }
                    //MARK: - 이런 음식/약물은 조심해요
                    else if selectedTab == 1 {
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
                        
                    }
                    else if selectedTab == 2 {
                        //MARK: - 금기
                        VStack(alignment: .leading, spacing: 10){
                            PillDetailComponent(imageName: "icon-detail-block", text: "절대 복용 금지에요")
                            let interactionText2 = medicine.drugInfo?.BriefMonoContraIndication ?? "준비중 입니다!"
                            let styledText = interactionText2
                                .replacingOccurrences(of: "<br>", with: "")
                            Text(styledText)
                                .font(
                                    Font.custom("SUIT", size: 15)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                                .frame(width: 340, alignment: .topLeading)
                            
                            
                            
                        }.padding(.horizontal, 20) // Side padding
                            .padding(.vertical, 20) // Vertical padding
                            .background(.white)
                        //MARK: - 신중한 복용
                    }
                    else if selectedTab == 3 {
                        VStack(alignment: .leading, spacing: 10){
                            let interactionText3 = medicine.drugInfo?.BriefMonoSpecialPrecaution ?? "준비중 입니다!"
                            let styledText = interactionText3
                                .replacingOccurrences(of: "<br>", with: "")
                            PillDetailComponent(imageName: "icon-detail-caution", text: "신중한 복용이 필요해요!")
                            Text(styledText)
                                .font(
                                    Font.custom("SUIT", size: 15)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.33))
                                .frame(width: 340, alignment: .topLeading)
                        }.padding(.horizontal, 20) // Side padding
                            .padding(.vertical, 20) // Vertical padding
                            .background(.white)
                    
                    }
                    }
                }
        }.background(Color(red: 0.96, green: 0.96, blue: 0.98, opacity: 1))
            .navigationTitle("약 세부정보")
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
                kdCode: "646900710",
                atcCode: AtcCode(code: "ATC001", score: 1),
                count: 10,
                isTaken: false,
                isOverLap: false,
                drugInfo: DrugInfo(IdentaImage: "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", Pictogram: [], BriefMonoContraIndication:  "본제 과민증, <br>\r\n소화성 궤양, <br>\r\n심한 혈액이상, <br>\r\n심한 간·신장애, <br>\r\n심한 심장기능저하, <br>\r\n아스피린 천식(NSAID에 의한 천식발작 유발) 또는 그 기왕력자, <br>\r\n바르비탈계 약물·삼환계 항우울제 복용자, <br>\r\n알코올 복용자.", BriefMonoSpecialPrecaution:"간·신장애 또는 그 기왕력자, <br>\r\n소화성 궤양 기왕력자, <br>\r\n혈액이상 또는 그 기왕력자, <br>\r\n출혈경향자, <br>\r\n심장기능이상, <br>\r\n과민증 기왕력자, <br>\r\n기관지 천식, <br>\r\n고령자, <br>\r\n만 2세 미만, <br>\r\n임부, 수유부, <br>\r\n와파린 장기복용자, <br>\r\n리튬·치아짓계 이뇨제 복용자.", BriefMono:  "1. 4-6시간 간격을 두고 복용하며, 일일 최대용량 4g을 초과하여 복용하지 않습니다.  <br>\r\n2. 복용 중인 타 약물이 아세트아미노펜을 포함하는지 확인하며, 이 약을 복용하는 동안 음주를 피합니다. <br>\r\n3. 의사 또는 약사의 지시없이 통증에 10일 이상, 발열에 3일 이상 사용하지 않습니다. <br>\r\n4. 알레르기 반응, 피부 발진, 눈 및 피부의 황변, 비정상적인 출혈이 나타나는 경우 즉시 의사, 약사에게 알립니다. \r\n", BriefIndication: "통증을 완화하고 열을 낮춥니다.",Interaction:  "1. 다음을 포함하여 복용 중인 모든 약물에 대해 의사, 약사에게 알립니다. <br><div style=\"margin-left:20px\">\r\n- 다른 해열진통제 <br>\r\n- 항응고제(와파린)  <br></div> \r\n\r\n2. 복용 중/예정인 약물에 아세트아미노펜(acetaminophen)이 함유되어 있는 지 신중히 확인합니다. 하루에 4g 초과 복용 시, 간손상의 위험이 높아질 수 있습니다. <br> \r\n3. 이 약을 복용하는 동안 술은 마시지 않습니다. 간손상의 위험이 높아질 수 있습니다.")
                
            )
        )
        
        return MedicineDetailView(medicine: medicine)
    }
}
