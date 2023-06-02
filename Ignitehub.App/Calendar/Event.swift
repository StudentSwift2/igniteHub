//
//  Event.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/16/23.
//

import Foundation

var eventsList : [Event] = [Event(id: 343434, name: "Testing", startDate: Date(), endDate: Date(), description: "Just a test"),
    Event(id: 343434333, name: "Test 2", startDate: CalendarHelper().addDays(date: CalendarHelper().firstOfMonth(date: Date()), days: 12) , endDate: CalendarHelper().addDays(date: CalendarHelper().firstOfMonth(date: Date()), days: 12), description: "Something \nSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomething \n SomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethin \n gSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomething"),
    
]
class Event {
    var id: Int!
    var name: String!
    var startDate: Date!
    var endDate: Date!
    var description : String!
    var url : URL!

    init() {
        
    }
    
    init(id: Int!, name: String!, startDate: Date!, endDate: Date!, description: String!) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
    }
    
    init(id: Int!, name: String!, startDate: Date!, endDate: Date!, description: String!, url: URL) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.url = url
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
