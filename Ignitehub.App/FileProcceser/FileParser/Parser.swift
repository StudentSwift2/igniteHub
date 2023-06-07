//
//  Parser.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/18/23.
//

import Foundation

//
// Contains the class for all the parsing using NSScanner
//


// NOTE: _ = is needed is certain areas to avoid an overwhelming amount of warnings

final class FileParser {
    
    // Breaks an .ics file in the form of a string into its component events, also as strings
    static func parseToBock(fileAsString: String) -> [String]? {
        

        
        // Recive  string
        let string = fileAsString;

        // Initalise holder arrray for result
        var arrayOfBlocks: [String] = [];
        
        // Initalise a scanner on the provided string
        let scanner = Scanner(string: string);
        
        // Repeat while data is still unparsed
        while !scanner.isAtEnd {
            
            // Find the start of an event
            _ = scanner.scanUpToString("BEGIN:VEVENT");
            
            // Create a varable and write the event to it
            let newBlock = scanner.scanUpToString("END:VEVENT");
            
            // If the varable has a value add it to the result array
            if let newBlock = newBlock {
                arrayOfBlocks.append(newBlock);
            }
            
        }
        
        // Return the final array of events
        return arrayOfBlocks;
    }

    // Turn an individual Event as a string into a StringData instance
    static func blockParser(block: String) -> StringData? {
       
        // Recive string
        let string = block;
        
        // Initalise a scanner on the provided string
        let blockScanner = Scanner(string: string);

        // Break off each of the component fields
        
        // NOTE: I can't be bothered to document all of this
        
        // DTSTART
        _ = blockScanner.scanUpToString("DTSTART;");
        _ = blockScanner.scanString("DTSTART;");
        _ = blockScanner.scanUpToString(":");
        _ = blockScanner.scanString(":");
        let dtstart = blockScanner.scanUpToString("\r\n");
            
        // DTEND
        _ = blockScanner.scanUpToString("DTEND;");
        _ = blockScanner.scanString("DTEND;");
        _ = blockScanner.scanUpToString(":");
        _ = blockScanner.scanString(":");
        let dtend = blockScanner.scanUpToString("\r\n");
        
        // DTSTAMP
        _ = blockScanner.scanUpToString("DTSTAMP:");
        _ = blockScanner.scanString("DTSTAMP:");
        let dtstamp = blockScanner.scanUpToString("\r\n");
        
        // CREATED
        _ = blockScanner.scanUpToString("CREATED:");
        _ = blockScanner.scanString("CREATED:");
        let created = blockScanner.scanUpToString("\r\n");
        
        // LAST-MODIFIED
        _ = blockScanner.scanUpToString("LAST-MODIFIED:");
        _ = blockScanner.scanString("LAST-MODIFIED:");
        let lastModified = blockScanner.scanUpToString("\r\n");
        
        // UID
        _ = blockScanner.scanUpToString("UID:");
        _ = blockScanner.scanString("UID:");
        let uid = blockScanner.scanUpToString("\r\n");
        
        // SUMMARY
        _ = blockScanner.scanUpToString("SUMMARY:");
        _ = blockScanner.scanString("SUMMARY:");
        let summary = blockScanner.scanUpToString("\r\n");
        
        // DESCRIPTION
        _ = blockScanner.scanUpToString("DESCRIPTION:");
        _ = blockScanner.scanString("DESCRIPTION:");
        let description = blockScanner.scanUpToString("\r\n");
        
        // URL
        _ = blockScanner.scanUpToString("URL:");
        _ = blockScanner.scanString("URL:");
        let url = blockScanner.scanUpToString("\r\n");
        
    
        // Return the parsed fields as a StringData element if required fields are provided
        // return nil if required fields aren't met
        if let dtstart = dtstart, let dtend = dtend, let dtstamp = dtstamp, let created = created, let lastModified = lastModified, let uid = uid, let summary = summary, let description = description, let url = url {
            let newData = StringData(dtstart: dtstart, dtend: dtend, dtstamp: dtstamp, created: created, lastModified: lastModified, uid: uid, summary: summary, description: description, url: url);
            return newData;
        } else {
            return nil;
        }
    }
}

