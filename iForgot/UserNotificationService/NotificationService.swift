//
//  NotificationService.swift
//  UserNotificationService
//
//  Created by Jeremy on 4/14/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            if request.identifier == "" {
                bestAttemptContent.body = "\(bestAttemptContent.body), jeremy"
            }
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            contentHandler(bestAttemptContent)
        }
        
        if let imageURLString = bestAttemptContent?.userInfo["image"] as? String,
            let URL = URL(string: imageURLString)
        {
            downloadAndSave(url: URL) { localURL in
                if let localURL = localURL {
                    do {
                        let attachment = try UNNotificationAttachment(identifier: "image_downloaded", url: localURL, options: nil)
                        self.bestAttemptContent?.attachments = [attachment]
                    } catch {
                        print(error)
                    }
                }
                contentHandler(self.bestAttemptContent!)
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    private func downloadAndSave(url: URL, handler: @escaping (_ localUrl: URL?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var localUrl: URL? = nil
//            if let data = data {
//                let ext = (url.absoluteString as NSString).pathExtension
//                let cacheURL = FileManager.default.temporaryDirectory//URL(fileURLWithPath: FileManager.default.cachesDirectory)
//                let url = cacheURL.appendingPathComponent(url.absoluteString.md5).appendingPathExtension(ext)
//                
//                if let _ = try? data.write(to: url) {
//                    localUrl = url
//                }
//            }
            handler(localUrl)
        }
        task.resume()
    }

}
