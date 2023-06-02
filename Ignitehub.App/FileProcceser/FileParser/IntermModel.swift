//
//  IntermModel.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/24/23.
//

import Foundation

//
// Contains model to hold the directly extracted string data
//


struct StringData {
    var dtstart: String;
    var dtend: String;
    var dtstamp: String;
    var created: String;
    var lastModified: String;
    var uid: String;
    var summary: String;
    var description: String;
    var url: String;
    
    init(dtstart: String, dtend: String, dtstamp: String, created: String, lastModified: String, uid: String, summary: String, description: String, url: String) {
        self.dtstart = dtstart;
        self.dtend = dtend;
        self.dtstamp = dtstamp;
        self.created = created;
        self.lastModified = lastModified;
        self.uid = uid;
        self.summary = summary;
        self.description = description;
        self.url = url;
    }
}
