//
//  Extension.swift
//  SchedulePal
//
//  Created by Shawn Shirazi on 2/6/23.
//

import Foundation
import SwiftUI

extension DateFormatter {
    convenience init(dateFormat: String, calender: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calender
        self.locale = Locale(identifier: "js_JP")
    }
}

extension CalenderWeekListView {
    func makeDays() -> [Date] {
        guard let firstWeek = calender.dateInterval(of: .weekOfMonth, for: date),
                let lastWeek = calender.dateInterval(of: .weekOfMonth, for: firstWeek.end - 1)
        else {
            return []
        }
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        
        return calender.generateDays(for: dateInterval)
    }
}


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]
        
        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date = date else { return }
            
            guard date < dateInterval.end else {
                stop = true
                return
            }
            
            dates.append(date)
            
        }
        
        return dates
    }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(
            for: dateInterval,
               matching: dateComponents([.hour, .minute, .second], from: dateInterval.start))
    }
}

extension Date {
    func startOfMoneth(using calender: Calendar) -> Date {
        calender.date(from: calender.dateComponents([.year, .month], from: self)
        ) ?? self
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
