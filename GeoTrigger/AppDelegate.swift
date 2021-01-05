//
//  AppDelegate.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import UIKit
import Foundation
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var locationManager: LocationManager = LocationManager.shared
    let notificationCenter = NotificationCenter.shared
    let operationQueue = OperationQueue()
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")
        self.locationManager.appOpened = true
        return true
    }
    
}
