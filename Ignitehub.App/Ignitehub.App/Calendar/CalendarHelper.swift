//
//  CalendarHelper.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/15/23.
//

import Foundation
import UIKit

class CalendarHelper {
    let calendar = Calendar.current
    
    func plusMonth(date:Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date:Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func timeString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date:Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func daysOfMonth(date:Date) -> Int
    {
        let component = calendar.dateComponents([.day], from: date)
        return component.day!
    }
    
    func firstOfMonth(date:Date) -> Date
    {
        let component = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: component)!
    }
    
    func weekDay(date:Date) -> Int
    {
        let component = calendar.dateComponents([.weekday], from: date)
        return component.weekday! - 1
    }
    
    func addDays(date : Date, days: Int) -> Date {
        return calendar.date(byAdding: .day, value: days, to: date)!
    }
    
    func sundayForDate(date:Date) -> Date
    {
        var current = date
        let oneWeekAgo = addDays(date: current, days: -7)
        
        while(current > oneWeekAgo) {
            let currentWeekDay = calendar.dateComponents([.weekday], from: current).weekday
            if(currentWeekDay == 1) {
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }
    
}