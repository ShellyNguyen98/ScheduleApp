//
//  WeeklyCalenderView.swift
//  SchedulePal
//
//  Created by Shawn Shirazi on 2/6/23.
//

import SwiftUI
import CoreData

struct weeklyCalenderView: View {
    
    let calender: Calendar
    let monthDayFormatter: DateFormatter
    let dayFormatter: DateFormatter
    let weekDayFormatter: DateFormatter
    
    @State var selectedDate = Self.now
    private static var now = Date()
    
    init(calender: Calendar) {
        self.calender = calender
        self.monthDayFormatter = DateFormatter(dateFormat: "MM/dd", calender: calender)
        self.dayFormatter = DateFormatter(dateFormat: "d", calender: calender)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calender: calender)
    }
    
    var body: some View {
        VStack {
            CalenderWeekListView(
                calender: calender,
                date: $selectedDate,
                content: { date in
                    Button(action: { selectedDate = date }) {
                        Text("00")
                            .font(.system(size: 13))
                            .padding(8)
                            .foregroundColor(.clear)
                            .overlay(
                                Text(dayFormatter.string(from: date))
                                    .foregroundColor(
                                        calender.isDate(date, inSameDayAs: selectedDate)
                                        ? Color.black
                                        : calender.isDateInToday(date) ? .blue
                                        : .gray
                                    )
                            )
                            .overlay(
                                Circle()
                                    .foregroundColor(.gray.opacity(0.38))
                                    .opacity(calender.isDate(date, inSameDayAs:
                                                                selectedDate) ? 1 : 0)
                            )
                    }
                },
                header: { date in
                    Text("00")
                        .font(.system(size: 13))
                        .padding(8)
                        .foregroundColor(.clear)
                        .overlay(
                            Text(weekDayFormatter.string(from: date))
                                .font(.system(size: 15))
                        )
                },
                title: { date in
                    HStack {
                        Text(monthDayFormatter.string(from: selectedDate))
                            .font(.headline)
                            .padding()
                        Spacer()
                    }
                    .padding(.bottom, 6)
                },
                weekSwitcher: { date in
                    Button {
                        withAnimation {
                            guard let newDate = calender.date (
                                byAdding: .weekOfMonth,
                                value: -1,
                                to: selectedDate
                            ) else {
                                return
                            }
                            
                            selectedDate = newDate
                        }
                        3
                    } label: {
                        Label(
                            title: { Text("Previous") },
                            icon: { Image(systemName: "chevron.left")}
                        )
                        .labelStyle(IconOnlyLabelStyle())
                        .padding(.horizontal)
                    }
                    Button {
                        
                        withAnimation {
                            guard let newDate = calender.date (
                                byAdding: .weekOfMonth,
                                value: +1,
                                to: selectedDate
                            ) else {
                                return
                            }
                            
                            selectedDate = newDate
                        }
                        
                    } label: {
                        Label(
                            title: { Text("Next") },
                            icon: { Image(systemName: "chevron.right")}
                        )
                        .labelStyle(IconOnlyLabelStyle())
                        .padding(.horizontal)
                    }
                }
            )
            
        }
        .padding()
        
    }
}


//struct WeeklyCalenderView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeeklyCalenderView()
//    }
//}
