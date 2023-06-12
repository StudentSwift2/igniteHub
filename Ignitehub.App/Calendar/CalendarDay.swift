//
//  CalendarDay.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/31/23.
//

import Foundation

struct CalendarDay {
    var day : String!
    var month : Month!
    
    enum Month
    {
        case previous
        case current
        case next
    }
}
