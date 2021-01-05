//
//  NotificationCenter.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import Foundation
import UserNotifications
import UIKit

class NotificationCenter : NSObject, ObservableObject {
    
    static let shared = NotificationCenter()
        
    let userNotificationCenter = UNUserNotificationCenter.current()
    var authorizationStatus = UNAuthorizationStatus.notDetermined
    
    private override init() {
        super .init()
        self.requestNotificationAuthorization()
        self.userNotificationCenter.delegate = self
        self.setPermissions()
    }
    func sendNotification(title: String, body: String, identifier: String) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.badge = NSNumber(value: 1)
        
        if let url = Bundle.main.url(forResource: "dune",
                                    withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                            url: url,
                                                            options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: identifier,     // "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        self.userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
        print("notification sent")
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
            self.setPermissions()
        }
    }
    
    func setPermissions() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            self.authorizationStatus = settings.authorizationStatus
        }
    }

}

extension NotificationCenter : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
        
    
}
