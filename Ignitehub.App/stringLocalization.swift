//
//  stringLocalization.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/12/23.
//

import UIKit

extension String{
    
    struct Localized {
        static let dateLabel = NSLocalizedString("DateLabel", comment: "Date: ")
        static let hoursLabel = NSLocalizedString("hoursLabel", comment: "Hours: ")
        static let descriptionLabel = NSLocalizedString("descriptionLabel", comment: "Description: ")
        
        static let monday = NSLocalizedString("Monday", comment: "Monday")
        static let tuesday = NSLocalizedString("Tuesday", comment: "Tuesday")
        static let wednesday = NSLocalizedString("Wednesday", comment: "Wednesday")
        static let thursday = NSLocalizedString("Thursday", comment: "Thursday")
        static let friday = NSLocalizedString("Friday", comment: "Friday")
        static let saturday = NSLocalizedString("Saturday", comment: "Saturday")
        static let sunday = NSLocalizedString("Sunday", comment: "Sunday")
        
        static let weekly = NSLocalizedString("weekly", comment: "Weekly")
        static let daily = NSLocalizedString("daily", comment: "Daily")
        
        static let collaboration = NSLocalizedString("Collaboration", comment: "Description of ignite hub")
        static let tour = NSLocalizedString("360Tour", comment: "Tour of hub")
        static let speakers = NSLocalizedString("Speakers", comment: "Speakers Title")
        static let fireside = NSLocalizedString("fireside", comment: "Fireside title")
        static let download = NSLocalizedString("download", comment: "Download")
        static let techSeries = NSLocalizedString("techSeries", comment: "TechSeries Title")
        static let empower = NSLocalizedString("empower", comment: "Empower IT community")
        static let input = NSLocalizedString("input", comment: "Hub input")
        static let partners = NSLocalizedString("partners", comment: "Hub partners")
        static let hours = NSLocalizedString("hours", comment: "Hub opening hours")
        static let days = NSLocalizedString("days", comment: "Hub opening days")
        static let follow = NSLocalizedString("follow", comment: "Follow Us")
        static let about = NSLocalizedString("about", comment: "IgniteHubs about info")
        static let vision = NSLocalizedString("vision", comment: "vision")
        static let visionDesc = NSLocalizedString("visionDesc", comment: "Described hubs vision")
        static let mission = NSLocalizedString("mission", comment: "mission")
        static let missionDesc = NSLocalizedString("missionDesc", comment: "Explains the hubs mission")
        static let staff = NSLocalizedString("staff", comment: "staff")
        static let director = NSLocalizedString("director", comment: "Director of igniteHub")
        static let biography = NSLocalizedString("biography", comment: "biography")
        static let biographyDesc = NSLocalizedString("biographyDesc", comment: "Describes the directors biography")
        static let techTrain = NSLocalizedString("techTrain", comment: "Technical training position")
        static let labCord = NSLocalizedString("labCord", comment: "Lab Coordinator")
        
        static let resources = NSLocalizedString("resources", comment: "Hub resources")
        static let jobs = NSLocalizedString("jobs", comment: "Jobs & Opportunities")
        static let videos = NSLocalizedString("videos", comment: "Video Archives")
    }
}
