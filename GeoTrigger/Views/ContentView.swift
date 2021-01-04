//
//  ContentView.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import SwiftUI
import CoreLocation
import UserNotifications


struct ContentView: View {
    let appConfig = AppConfig.config    
    @ObservedObject var locationManager = LocationManager.shared
    @ObservedObject var notificationCenter = NotificationCenter.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    var body: some View {
        
        VStack {
            
            if locationManager.enteredGeoFence {
                Text("Entered Geofence")
            }
                                                
            switch locationManager.authorizationStatus {
                case .notDetermined:
                    Text("Not Determined")
                case .restricted:
                    Text("Restricted")
                case .denied:
                    Text("Denied")
                case .authorizedWhenInUse:
                    Text("Authroized When In Use")
                case .authorizedAlways:
                    Text("Authroized Always")
                @unknown default:
                    Text("Default")
            }
                                    
            
            switch notificationCenter.authorizationStatus {
                case .notDetermined:
                    Text("Notification Status Not Determined")
                case .denied:
                    Text("Notification Status Denied")
                case .authorized:
                    Text("Notification Status Authorized")
                case .provisional:
                    Text("Notification Status Provisional")
                case .ephemeral:
                    Text("Notification Status Empheral")
                @unknown default:
                    Text("Notification Status DEFAULT")
            }
            
            Button(action: {
                print("hello")
                self.appDelegate.scheduleAppRefresh()
            }) {
                Text("Click me")
            }
            
        }        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
