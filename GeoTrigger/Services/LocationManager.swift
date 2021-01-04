//
//  LocationManager.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 12/29/20.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager : CLLocationManager, ObservableObject  {
    
    @Published open var enteredGeoFence : Bool = false
    
    //TODO: Debug variable
    @Published open var appOpened : Bool = false
    
    static let shared = LocationManager()
    
    let notificationCenter = NotificationCenter.shared
    var taskManager : TaskManager?
            
    var lat : Double?
    var lng : Double?
    
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
    
    func setHighAccuracy() {
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.distanceFilter = 5
        self.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print ("started to monitor for region")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print ("did determine state")
        if state == CLRegionState.inside {
            enteredGeoFence = true
        } else {
            enteredGeoFence = false
        }        
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited region")        
        // self.taskManager?.runTask()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered reion")
        print("checking debug var didOpenApp")
        print(self.appOpened)
        self.taskManager?.runTask()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      print("didChangeAuthorization")
        
        if CLLocationManager.locationServicesEnabled() {
            print("locationServicesEnabled = True")
        }
        else {
            print("locationServicesEnabled = False")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Test didUpdateLocations")
        self.lat = locations[0].coordinate.latitude
        self.lng = locations[0].coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("LocationManager didFailWithError \(error.localizedDescription)")
    }
    
}
