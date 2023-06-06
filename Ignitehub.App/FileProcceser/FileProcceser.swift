//
//  FileProcceser.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/24/23.
//

import Foundation

//
// Contains the class for retreving the Ignithub data
//

struct FileProccesser {
    
    // Fetch and process the caender data
    static func getIgniteHubCalerderData() -> [Event]? {
        
        // Static URL for IgniteHub events
        let url = URL(string: "https://ignitehubmc.com/events/list/?ical=1")!;
        
        // Static file location
        let file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Calender.ics");
        
        // Download file
        Downloader.downloadFile(siteURL: url, fileURL: file);
        
        // Convert file to string
        let fileAsString = Converter.FileToString(file: file);
        
        
        // Check is the string is nil, if so, return
        guard let fileAsString = fileAsString else { return nil }
        
        // Break the file into component events
        let eventBlocks = FileParser.parseToBock(fileAsString: fileAsString);
        
        // Check if the Bocks are nil, if so, return
        guard let eventBlocks = eventBlocks else { return nil }
        
        // Initialize an empty holder array
        var eventsinterim: [StringData] = []
        
        // Run for every event
        for event in eventBlocks {
            // Parse the event into conponent strings
            let parsedEvent = FileParser.blockParser(block: event);
            
            // If the pased event has a value add it to the holder array
            if let parsedEvent = parsedEvent { eventsinterim.append(parsedEvent) }
        }
        
        // Initilize a holder array for the final objects
        var events: [Event] = [];

        // Run for each of the events
        for event in eventsinterim {
            
            // Convert the event into an Event object
            let event = Converter.interimToModel(interimModel: event);
            
            // If the event has a value add it to the holder array
            if let event = event { events.append(event) }
        }
        
        // Return the events
        return events;

    }
}
