//
//  NotificationHandler.swift
//  iForgot
//
//  Created by Jeremy on 4/14/17.
//  Copyright © 2017 Jeremy. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationHandler()
    
    private override init() {}
    
    //MARK: -UNUserNotificatonCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        response.notification.request.content.userInfo
//        if let category = response.notification.request.content.categoryIdentifier
//        response.actionIdentifier
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
        print("didReceive")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        print("willpresent")
    }
}
