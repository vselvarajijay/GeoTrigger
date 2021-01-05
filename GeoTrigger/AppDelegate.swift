//
//  AppDelegate.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import UIKit
import Foundation
import BackgroundTasks


/// <#Description#>
class AppDelegate: NSObject, UIApplicationDelegate {
    
    var locationManager: LocationManager = LocationManager.shared
    let notificationCenter = NotificationCenter.shared
    let operationQueue = OperationQueue()
   
    
    /// <#Description#>
    /// - Parameters:
    ///   - application: <#application description#>
    ///   - launchOptions: <#launchOptions description#>
    /// - Returns: <#description#>
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")        
        return true
    }
    
}
