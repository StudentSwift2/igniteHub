//
//  FileConverter.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/19/23.
//

import Foundation

class Converter {
    static func FileToString(file: URL) -> String? {
        
        let string: String
        let pathToFile = file.path
        
        do {
            try string = String(contentsOfFile: pathToFile)
        } catch {
            return nil;
        }
        return string
        
    }
    
    static func interimToModel(interimModel: StringData) -> Event? {
        
        let model = interimModel;
        
        let dateFormater = ISO8601DateFormatter();
        dateFormater.formatOptions = [
            .withDay,
            .withMonth,
            .withYear,
            .withTime,
        ];
        
        let startDate = dateFormater.date(from: model.dtstart);
        let endDate = dateFormater.date(from: model.dtend );
        let dateStamp = dateFormater.date(from: model.dtstamp );
        let created = dateFormater.date(from: model.created );
        let lastModified = dateFormater.date(from: model.lastModified );
        let id = model.uid;
        let name = model.summary;
        let description = model.description.replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "\\,", with: ",");
        
        let url = URL(string: model.url );
        
        guard let startDate = startDate, let endDate = endDate, let dateStamp = dateStamp, let created = created, let lastModified = lastModified, let url = url else { return nil }
        
        return Event(startDate: startDate, endDate: endDate, dateStamp: dateStamp, created: created, lastModified: lastModified, id: id, name: name, description: description, url: url);
        
    }
}


