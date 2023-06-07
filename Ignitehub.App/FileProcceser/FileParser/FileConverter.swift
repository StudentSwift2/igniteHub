//
//  FileConverter.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/19/23.
//

import Foundation

//
// Contains the class for handling all conversions 
//

final class Converter {
    
    // Convert a file into a String
    static func FileToString(file: URL) -> String? {
        
        // Recive file URL
        let string: String
        
        // Extract the path from the file URL
        let pathToFile = file.path
        
        
        // Turn the contents of the file at the specified path into a string
        // return nil if operation failed
        do {
            try string = String(contentsOfFile: pathToFile)
        } catch {
            return nil;
        }
        
        // return converted file
        return string
        
    }
    
    // Convert a StringData instance into a useable Event Instance
    static func interimToModel(interimModel: StringData) -> Event? {
        
        // Recive StringData instance
        let model = interimModel;
        
        // Initalise a date formater
        let dateFormater = ISO8601DateFormatter();
        
        // Set date formatter options to handle YYYYMMDDTHHMMSS
        dateFormater.formatOptions = [
            .withDay,
            .withMonth,
            .withYear,
            .withTime,
        ];
        
        
        // Convert dates into swift Date instances
        let startDate = dateFormater.date(from: model.dtstart);
        let endDate = dateFormater.date(from: model.dtend );
        let dateStamp = dateFormater.date(from: model.dtstamp );
        let created = dateFormater.date(from: model.created );
        let lastModified = dateFormater.date(from: model.lastModified );
        
        // Take model string properties as-is
        let id = model.uid;
        let name = model.summary;
        
        // Remove escaping characters from string, now works as multi-line string.
        let description = model.description.replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "\\,", with: ",");
        
        // convert url string into a URL instance
        let url = URL(string: model.url );
        
        // Return nil if required properties are missing
        guard let startDate = startDate, let endDate = endDate, let dateStamp = dateStamp, let created = created, let lastModified = lastModified, let url = url else { return nil }
        
        // Format values into a Event instance and return the instance
        return Event(startDate: startDate, endDate: endDate, dateStamp: dateStamp, created: created, lastModified: lastModified, id: id, name: name, description: description, url: url);
        
    }
}


