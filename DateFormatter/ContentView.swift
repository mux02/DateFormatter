//
//  ContentView.swift
//  DateFormatter
//
//  Created by Mohammed Almalki on 18/06/1444 AH.
//

import SwiftUI

struct ContentView: View {
    
    @State var user_Date : Date = .now // setDate previously
    @State var nowDate : Date = Date()
    
    // You can write your own custom date and save it to compare it with user picked date
    // ======================================================
    let StringToDate = "2000-04-12T12:45:12"
    func convertString_Date(Object: String) -> Date {
        let inDateFormatter_Object = DateFormatter()
        inDateFormatter_Object.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" // to recive ISO format date type
        guard let DateResult = inDateFormatter_Object.date(from: Object) else {
            return Date.now
        }
        return DateResult
    }

    func PrintCustomDate(Object: Date) -> String {
        let outDateFormatter = DateFormatter()
        outDateFormatter.locale = Locale(identifier: "AR") // for changing the type of calender language iden, Try AR or US and see the difference
        //outDateFormatter.dateStyle = .short // option
        outDateFormatter.dateFormat = "d MMM" // you can customize it :)
        return outDateFormatter.string(from: Object)
    }
    // ======================================================
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.nowDate = Date()
        }
    }
    
    func TimerFunction(from date: Date) -> String {
        
        let calender = Calendar(identifier: .gregorian)
        let timeValue = calender
            .dateComponents([.day, .hour, .minute, .second], from: nowDate, to: user_Date)
        
        return String(format: "%02d days left - %02d:%02d:%02d",
                      timeValue.day!,
                      timeValue.hour!,
                      timeValue.minute!,
                      timeValue.second!
        )
    }
    
    var body: some View {
        VStack {
            Image(systemName: "calendar.badge.clock")
                .imageScale(.large)
                .foregroundColor(.red)
            
            
            Text("Pick your date")
                .font(.system(size: 25).bold())
                .foregroundColor(.black)
            
            HStack {
                DatePicker("Date", selection: $user_Date)
                    .datePickerStyle(.graphical)
                    .foregroundColor(.black)
                    .colorMultiply(.red)
            }
            .padding()
            
            Button {
                self.timer // Click the button to start the timer
            } label: {
                Text("Start Timer")
                    .font(.system(size: 18).bold())
                    .padding(.vertical,18)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color.white)
            } // MARK: Button
            .padding(.horizontal,30)
            .padding(.top, 1)
            
            
            VStack {
                Text(TimerFunction(from:user_Date))
                    .font(.system(size: 20).bold())
                    .foregroundColor(.indigo)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.red.opacity(0.2))
            )
            .padding(.top, 20)
            .padding(.bottom, 5)
            
            VStack {
                // convertString_Date(Object: self.StringToDate).ISO8601Format() - printing the date in ISO format
                Text(PrintCustomDate(Object: convertString_Date(Object: self.StringToDate)))
                    .font(.system(size: 20).bold())
                    .foregroundColor(.indigo)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.red.opacity(0.2))
            )
            .padding(.top, 20)
            .padding(.bottom, 10)
            
        } // MARK: Vstack
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(.yellow.opacity(0.2))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
