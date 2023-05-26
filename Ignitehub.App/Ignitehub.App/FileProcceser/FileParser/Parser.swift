//
//  Parser.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/18/23.
//

import Foundation


class FileParser {
    
    
    static func parseToBock(fileAsString:String) -> [String]? {
        
        var string = fileAsString;

        var arrayOfBlocks: [String] = [];
        
        let scanner = Scanner(string: string);
        
        while !scanner.isAtEnd {
            _ = scanner.scanUpToString("BEGIN:VEVENT");
            let newBlock = scanner.scanUpToString("END:VEVENT");
            if newBlock != nil {
                arrayOfBlocks.append(newBlock!);
            }
            
        }
        return arrayOfBlocks;
    }

    static func blockParser(block: String) -> StringData? {
       
            
        let blockScanner = Scanner(string: block);
        blockScanner.charactersToBeSkipped = nil;
            
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
        
    
            
        if let dtstart = dtstart, let dtend = dtend, let dtstamp = dtstamp, let created = created, let lastModified = lastModified, let uid = uid, let summary = summary, let description = description, let url = url {
            let newData = StringData(dtstart: dtstart, dtend: dtend, dtstamp: dtstamp, created: created, lastModified: lastModified, uid: uid, summary: summary, description: description, url: url);
            return newData;
        } else {
            return nil;
        }
    }
}

