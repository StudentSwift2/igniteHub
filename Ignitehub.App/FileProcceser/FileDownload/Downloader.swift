//
//  Downloader.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/18/23.
//

import Foundation



class Downloader {
    
    static var url = URL(string: "https://ignitehubmc.com/events/list/?ical=1");
    static var file = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Calender.ics");
    
    static func downloadFile(siteURL: URL, fileURL: URL)  {
        let semaphore = DispatchSemaphore(value: 0);
        // Get destination URL
        let destinationFileUrl = fileURL;
        
        // Get URL to the source file
        let fileURL  = siteURL
        // Set up session
        let sessionConfig = URLSessionConfiguration.default;
        let session = URLSession(configuration: sessionConfig);
        
        // Create HTTP Request
        var request = URLRequest(url:fileURL);
        
        // Spoof a Wget client to bypass security and javascript
        request.addValue("Wget/1.21.2", forHTTPHeaderField: "User-Agent");
        
        
        // Begin the download
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                
                // print HTTP responce
                // MAYBE: Remove before final
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)");
                }
                
                // Check if a file already exists a destination and delete it if so
                if FileManager.default.fileExists(atPath: destinationFileUrl.path) {
                    do { try FileManager.default.removeItem(at: destinationFileUrl) } catch {}
                }
                
                // Move file to final destination
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl);
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)");
                }
                
            } else {
                // Failure
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
            semaphore.signal();
        }
        
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture);
    }
}
