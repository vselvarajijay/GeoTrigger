//
//  TaskManager.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 1/1/21.
//

import Foundation
import BackgroundTasks
import SwiftUI



/// <#Description#>
class TaskManager : NSObject {
        
    @ObservedObject var notificationCenter = NotificationCenter.shared

    
    /// <#Description#>
    func runTask() {
        
        var finished = false
        var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0);
        bgTask = UIApplication.shared.beginBackgroundTask(withName:"background-geo-check-task", expirationHandler: {() -> Void in
            // Time is up.
            if bgTask != UIBackgroundTaskIdentifier.invalid {
                // Do something to stop our background task or the app will be killed
                finished = true
            }
        })

        // Perform your background task here
        print("The task has started")
        let task_start_time = self.currentTimeMillis()
        while !finished {
            print("Not finished")
                        
            let task_run_current_time = self.currentTimeMillis()
            
            if task_run_current_time - task_start_time > AppConfig.config.longRunningThreadDuration {
                // Task has run for 10 seconds and is currently inside the geofence
                
                if LocationManager.shared.enteredGeoFence {
                    print("Looks good user is still in the geofence")
                    notificationCenter.sendNotification(title: "Background Task Completed ", body: "Background task ahs completed. Long running.", identifier: "background-task-notification-completed")
                }
                
                finished = true            
            } else {
                do {
                    print("sleeping")
                    sleep(AppConfig.config.longRunningThreadSleep)
                }
            }
        }
        
        print("task finished")

        // Indicate that it is complete
        UIApplication.shared.endBackgroundTask(bgTask)
        bgTask = UIBackgroundTaskIdentifier.invalid
    }
    
    
    /// <#Description#>
    /// - Returns: <#description#>
    func currentTimeMillis() -> Int64 {
        return Int64(NSDate().timeIntervalSince1970 * 1000)
    }

}
