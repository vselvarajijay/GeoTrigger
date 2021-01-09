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


/// <#Description#>
class AppConfig {
    
    static let config = AppConfig()        
        
    var monitoredRegions : Array<MonitoredRegion>
    var longRunningThreadDuration = 10000
    var longRunningThreadSleep : UInt32 = 1
    var regionAddresses = [
        "apple-hq": "1 Apple Park WayCupertino, CA 95014",
        "vijay-home": "1075 Market St. San Francisco, CA 94103"
    ]
    
    /// <#Description#>
    private init() {
        self.monitoredRegions = []
        for (identifier, address) in self.regionAddresses {
            geoCode(identifier: identifier, address: address)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - address: <#address description#>
    func geoCode(identifier: String, address: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            if (error != nil) {
                return
            }

            if let placemark = placemarks?[0]  {
                let centerLng = placemark.location?.coordinate.longitude ?? 0.0
                let centerLat = placemark.location?.coordinate.latitude ?? 0.0
                
                if centerLng != 0.0 && centerLat != 0.0 {
                    let monitoredRegion =  MonitoredRegion(identifier: identifier, address: address, centerLat: centerLat, centerLng: centerLng)
                    
                    // Monitored Regions stores region properties to be used later during region didEnter and didExit events
                    self.monitoredRegions.append(monitoredRegion)

                    let geoRegion = self.getGeoRegion(latitude: centerLat, longitude: centerLng, name: identifier)
                    LocationManager.shared.startMonitoring(for: geoRegion)
                }
            }
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - latitude: <#latitude description#>
    ///   - longitude: <#longitude description#>
    ///   - name: <#name description#>
    /// - Returns: <#description#>
    func getGeoRegion(latitude: Double, longitude: Double, name: String) -> CLCircularRegion {
        let geofenceRegionCenter = CLLocationCoordinate2DMake(latitude, longitude)
        let region = CLCircularRegion(center: geofenceRegionCenter,
                          radius: 40,
                          identifier: name)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }
    
}
