//
//  LocationManager.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import Foundation
import CoreLocation
import UIKit


/// <#Description#>
class LocationManager : CLLocationManager, ObservableObject  {
    
    @Published open var enteredGeoFence : Bool = false
        
    static let shared = LocationManager()
    
    var lastDistanceFromHome : Double  = 0
    
    let notificationCenter = NotificationCenter.shared
    var taskManager : TaskManager?
            
    var lat : Double?
    var lng : Double?
    
    
    
    /// <#Description#>
    private override init() {        
        super.init()
        self.taskManager = TaskManager()
        self.allowsBackgroundLocationUpdates = true
        self.delegate = self
        self.desiredAccuracy = kCLLocationAccuracyBest
        self.startUpdatingLocation()
        self.requestAlwaysAuthorization()
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.distanceFilter = 5
        
    }
    
    
    /// <#Description#>
    func setHighAccuracy() {
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.distanceFilter = 5
        self.startUpdatingLocation()
    }
    
}


extension LocationManager: CLLocationManagerDelegate {
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - region: <#region description#>
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print ("started to monitor for region")
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - state: <#state description#>
    ///   - region: <#region description#>
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print ("did determine state")
        if state == CLRegionState.inside {
            enteredGeoFence = true
        } else {
            enteredGeoFence = false
        }        
    }

    
    /// <#Description#>
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - region: <#region description#>
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited region")
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - region: <#region description#>
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered reion")
        print("checking debug var didOpenApp")
        // self.taskManager?.runTask()
        
        print("starting to update locations after entering a geofence")
        self.startUpdatingLocation()
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - status: <#status description#>
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      print("didChangeAuthorization")
        
        if CLLocationManager.locationServicesEnabled() {
            print("locationServicesEnabled = True")
        }
        else {
            print("locationServicesEnabled = False")
        }
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - locations: <#locations description#>
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lat = locations[0].coordinate.latitude
        self.lng = locations[0].coordinate.longitude
        print("Test didUpdateLocations: \(String(describing: self.lat)), \(String(describing: self.lng))")
        
        // get the most recent location
        let lastLocation = locations.last!
        
        // get location of home
        let home = CLLocation(latitude: 37.780666, longitude: -122.411591)
        
        // calculate the distance from home
        let distanceInMeters = lastLocation.distance(from: home)
        
        print("Distance from home: \(String(describing: distanceInMeters)) meters")
        
        if distanceInMeters < self.lastDistanceFromHome {
            print(">>>>>>>>>>> Getting closer to home")
        } else {
            print(">>>>>>>>>>> Getting further to home")
            self.taskManager?.runTask()
        }
        
        self.lastDistanceFromHome = distanceInMeters
        
        
        
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - manager: <#manager description#>
    ///   - error: <#error description#>
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("LocationManager didFailWithError \(error.localizedDescription)")
    }
    
}
