//
//  FileProcceser.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/24/23.
//

import Foundation


struct FileProccesser {
    
    
    static func getIgniteHubCalerderData() -> [Event]? {
        
        var url = URL(string: "https://ignitehubmc.com/events/list/?ical=1")!;
        
        var file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Calender.ics");
        
        Downloader.downloadFile(siteURL: url, fileURL: file);
        
        let fileAsString = Converter.FileToString(file: file);
        
        guard let fileAsString = fileAsString else { return nil }
        
        let eventBlocks = FileParser.parseToBock(fileAsString: fileAsString);
        
        guard let eventBlocks = eventBlocks else { return nil }
        
        var eventsinterim: [StringData] = []
        
        for event in eventBlocks {
            let parsedEvent = FileParser.blockParser(block: event);
            
            if let parsedEvent = parsedEvent { eventsinterim.append(parsedEvent) }
        }
        
        var events: [Event] = [];

        for event in eventsinterim {
            let event = Converter.interimToModel(interimModel: event);
            if let event = event { events.append(event) }
        }
        
        return events;

    }
}
