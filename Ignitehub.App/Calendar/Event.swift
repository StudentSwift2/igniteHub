//
//  Event.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/16/23.
//

import Foundation


var eventsList : [Event] = []

struct Event {
    var startDate: Date!;  // DTSTART
    var endDate: Date!;  // DTEND
    var dateStamp: Date!;  // DTSTAMP
    var created: Date!;  // CREATED
    var lastModeified:Date!;  // LAST-MODIFIED
    var id: String!;  // UID
    var name: String!;  // SUMMARY
    var description: String!;  // DESCRIPTION
    var url: URL!;  // URL

    
    init() {
        
    }
     
    init(startDate: Date!, endDate: Date!, dateStamp: Date!, created: Date!, lastModified: Date!, id: String!, name: String!, description: String!, url: URL!) {
            self.startDate = startDate;
            self.endDate = endDate;
            self.dateStamp = dateStamp;
            self.created = created;
            self.lastModeified = lastModified;
            self.id = id;
            self.name = name;
            self.description = description;
            self.url = url;
        }
   
    
    
    
    func eventsForDate(date: Date) -> [Event]
    {
        var daysEvents = [Event]()

        for event in eventsList
        {
            if(Calendar.current.isDate(event.startDate, inSameDayAs: date)) {
                let eventMonth = CalendarHelper().getMonth(date: event.startDate)
                let dateMonth = CalendarHelper().getMonth(date: date)
                if(eventMonth == dateMonth) {
                    daysEvents.append(event)
                }
            }
        }
        return daysEvents
    }
    
    func eventsForDateAndTime(date: Date, hour: Int) -> [Event]
    {
        var daysEvents = [Event]()

        for event in eventsList
        {
            if(Calendar.current.isDate(event.startDate, inSameDayAs: date)) {
                let eventHour = CalendarHelper().hoursFromDate(date: event.startDate)
                if eventHour == hour {
                    daysEvents.append(event)
                }
            }
        }
        return daysEvents
    }
    
}
