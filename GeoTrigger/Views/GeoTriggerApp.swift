//
//  GeoTriggerApp.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import SwiftUI
import CoreLocation

@main
struct GeoTriggerApp: App {
    
    // Adding AppDelegate delegate to GeoTriggerApp
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {                        
            ContentView()
        }
    }
}
