//
//  AppDelegate.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import UIKit
import Foundation

class AppDelegate: NSObject, UIApplicationDelegate {        
    
    var backgroundTaskId: UIBackgroundTaskIdentifier? = nil
    var locationManager: LocationManager? = LocationManager.shared
    let notificationCenter = NotificationCenter.shared
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("will terminate")
    }
    
}
