//
//  AppConfig.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 1/1/21.
//

import Foundation
import CoreLocation

struct MonitoredRegion {
    var identifier: String
    var address : String
    var centerLat : Double
    var centerLng : Double
}


class AppConfig {
    
    static let config = AppConfig()
        
    var monitoredRegions : Array<MonitoredRegion>
    var longRunningThreadDuration = 10000
    var longRunningThreadSleep : UInt32 = 1
    
    private init() {
        self.monitoredRegions = []
        
        let addresses = [
            "apple-hq": "1 Apple Park WayCupertino, CA 95014",
            "vijay-home": "1075 Market St. San Francisco, CA 94103"
        ]
        
        for (identifier, address) in addresses {
            geoCode(identifier: identifier, address: address)
        }
        
    }

    func geoCode(identifier: String, address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if (error != nil) {
                return
            }

            if let placemark = placemarks?[0]  {
                let centerLng = placemark.location?.coordinate.longitude ?? 0.0
                let centerLat = placemark.location?.coordinate.latitude ?? 0.0
                let name = placemark.name!
                let country = placemark.country!
                let region = placemark.administrativeArea!
                print("--------------------------------------------")
                print("\(centerLng),\(centerLng)\n\(name),\(region) \(country)")
                let geoRegion = MonitoredRegion(identifier: identifier, address: address, centerLat: centerLat, centerLng: centerLng)
                self.monitoredRegions.append(geoRegion)
                self.startMonitoring(latitude: centerLat, longitude: centerLng, name: identifier)
            }
        }
    }
    
    func startMonitoring(latitude: Double, longitude: Double, name: String) {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(latitude, longitude)
        let region = CLCircularRegion(center: geofenceRegionCenter,
                          radius: 40,
                          identifier: name)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        LocationManager.shared.startMonitoring(for: region)
    }
    
}
