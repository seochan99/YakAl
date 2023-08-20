import SwiftUI

struct DayModel: Identifiable {
    let id = UUID()
    let date: Date
    let medications: [Medicine] // List of medications for the day
    
    var dayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    var weekdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
    var fullWeekdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }
}

struct CalendarWeekView: View {
    var weekDates: [Date]
    
    var body: some View {
        HStack(spacing: 30) {
            VStack {
                HStack{
                    Text("일")
                    Text("월")
                    Text("화")
                    Text("수")
                    Text("목")
                    Text("금")
                    Text("토")
                    
                }
                
            ForEach(weekDates, id: \.self) { date in
                
                VStack {
                    Text("\(date.day)")
                        .font(.headline)
                }
                    
                }
            }
        }
    }
}

struct CalendarSwiftUIView: View {
    @State private var currentDate = Date()
    @State private var isExpanded = false

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter
    }

    var body: some View {
        ScrollView{
            
        
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image(systemName: "arrow.left")
                }
                
                Text(dateFormatter.string(from: currentDate))
                    .font(
                        Font.custom("SUIT", size: 15)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color(red: 0.38, green: 0.38, blue: 0.45))
                
                Button(action: {
                    self.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: self.currentDate) ?? self.currentDate
                }) {
                    Image(systemName: "arrow.right")
                }
                Spacer()
            }
            
            if isExpanded {
                ForEach(0..<5, id: \.self) { _ in
                    // Calculate week dates and pass them to CalendarWeekView
                    CalendarWeekView(weekDates: [Date(), Date(), Date(), Date(), Date(), Date(), Date()])
                }
            } else {
                CalendarWeekView(weekDates: [Date(), Date(), Date(), Date(), Date(), Date(), Date()])
            }
            
            Button(action: {
                self.isExpanded.toggle()
            }) {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            }
            
            Rectangle()
                .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.98))
                .frame(width: 380, height: 200) // Adjust the height as needed
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 1)
                )
            
            // Loop through DayModels and display medication info
            ForEach(0..<5) { _ in
                let dummyDayModel = DayModel(date: Date(), medications: [
                    Medicine(id: 1, image: "image_덱시로펜정", name: "약물A", ingredients: "성분 A", dangerStat: 0, isTaken: false),
                    Medicine(id: 2, image: "image_덱시로펜정", name: "약물B", ingredients: "성분 B", dangerStat: 1, isTaken: false)
                ])
                
                VStack {
                    Text("\(dummyDayModel.fullWeekdayText), \(dummyDayModel.weekdayText)")
                        .font(.headline)
                    Text(dummyDayModel.dayText)
                        .font(.headline)
                }
                
                ForEach(dummyDayModel.medications, id: \.self) { medication in
                    Text(medication.name)
                }
            }
        }
        .padding()
    }
    }
}


struct CalendarSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarSwiftUIView()
    }
}

extension Date {
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
}
