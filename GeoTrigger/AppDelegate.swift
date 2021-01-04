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
    
    var backgroundTaskId: UIBackgroundTaskIdentifier? = nil
    var locationManager: LocationManager = LocationManager.shared
    let notificationCenter = NotificationCenter.shared
    let operationQueue = OperationQueue()
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")
        self.locationManager.appOpened = true
        self.registerBackgroundTasks()
        return true
    }    
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("will terminate")
        self.locationManager.appOpened = false
    }
    
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.apple-samplecode.ColorFeed.refresh", using: nil) { (task) in
           print("BackgroundAppRefreshTaskScheduler is executed NOW!")
           print("Background time remaining: \(UIApplication.shared.backgroundTimeRemaining)s")
           task.expirationHandler = {
             task.setTaskCompleted(success: false)
           }

           // Do some data fetching and call setTaskCompleted(success:) asap!
           let isFetchingSuccess = true
           task.setTaskCompleted(success: isFetchingSuccess)
         }
    
        
        /*
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.apple-samplecode.ColorFeed.refresh", using: nil) { task in
             self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
         */
     }
    
    func scheduleAppRefresh() {
       let request = BGAppRefreshTaskRequest(identifier: "com.example.apple-samplecode.ColorFeed.refresh")
            
       // Fetch no earlier than 15 minutes from now
        request.earliestBeginDate = Date(timeIntervalSinceNow: 0.5)
       do {
          try BGTaskScheduler.shared.submit(request)
          print("submitted task request")
       } catch {
          print("Could not schedule app refresh: \(error)")
       }
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
       // Schedule a new refresh task
        print("handling app refresh")
       scheduleAppRefresh()

       // Create an operation that performs the main part of the background task
       let operation = TestOperation()
        
        
       
       // Provide an expiration handler for the background task
       // that cancels the operation
       task.expirationHandler = {
          operation.cancel()
       }

       // Inform the system that the background task is complete
       // when the operation completes
       operation.completionBlock = {
          task.setTaskCompleted(success: !operation.isCancelled)
       }

       // Start the operation
       operationQueue.addOperation(operation)
        
       operationQueue.waitUntilAllOperationsAreFinished()

     }
    
}
