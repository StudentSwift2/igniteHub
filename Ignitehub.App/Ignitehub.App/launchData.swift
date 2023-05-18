//
//  launchData.swift
//  Ignitehub.App
//
//  Created by Solano Paz, Miguel I (Student) on 5/3/23.
//

import Foundation

struct launchData: Codable {
    var launches : Int;
    
    static var archiveUrl = {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("launches").appendingPathExtension("plist")
    }
    
    init(launches: Int) {
        self.launches = launches
    }
    
    static func saveToFile(launchCount : Int) {
        let encoder = PropertyListEncoder()
        if let encodedCount = try? encoder.encode(launchData(launches: launchCount)) {
            try? encodedCount.write(to: archiveUrl(), options: .noFileProtection)
        }
    }
    
    static func loadCount() -> Int {
        let decoder = PropertyListDecoder()
        if let retrievedCount = try? Data(contentsOf: archiveUrl()), let decodedCount = try?  decoder.decode(launchData.self, from: retrievedCount){
            return decodedCount.launches
        }
        return 0;
    }
    
    
    
    
}
