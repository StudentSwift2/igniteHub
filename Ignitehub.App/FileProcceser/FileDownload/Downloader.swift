//
//  Downloader.swift
//  Ignitehub.App
//
//  Created by Zuczek, Samuel D (Student) on 5/18/23.
//

import Foundation

//
// Contains the class for downloading files
//


final class Downloader {
        
    // Download a remote file
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
                
                //
                // Uncomment the following code for debugging:
                //
                //
                // print HTTP responce
                //
                //if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                //    print("Successfully downloaded. Status code: \(statusCode)");
                //}
                //
                
                
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
                
                //
                // Uncomment the following code for debugging
                //
                // Failure
                //print("Error took place while downloading a file. Error description:", (error?.localizedDescription)!);
                //
                
            }
            semaphore.signal();
        }
        
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture);
    }
}
