//
//  FileConverter.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/19/23.
//

import Foundation

class Converter {
    static func FileTOString(file: URL) -> String? {
        
        let string: String
        let pathToFile = file.path
        
        do {
            try string = String(contentsOfFile: pathToFile)
        } catch {
            return nil;
        }
        return string
        
    }
}


