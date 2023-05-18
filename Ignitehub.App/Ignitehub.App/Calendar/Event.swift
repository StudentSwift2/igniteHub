//
//  Event.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/16/23.
//

import Foundation

var eventsList : [Event] = [Event(id: 343434, name: "Testing", startDate: Date(), endDate: Date(), description: "Just a test")]

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
    
    func eventsForDate(date: Date) -> [Event]
    {
        var daysEvents = [Event]()

        for event in eventsList
        {
            if(Calendar.current.isDate(event.startDate, inSameDayAs: date)) {
                daysEvents.append(event)
            }
        }
        return daysEvents
    }
    
}
