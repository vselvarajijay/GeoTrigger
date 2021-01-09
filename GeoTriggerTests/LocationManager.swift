//
//  LocationManager.swift
//  GeoTriggerTests
//
//  Created by Vijay Selvaraj on 1/5/21.
//

import Foundation
import CoreLocation

@testable import GeoTrigger

protocol LocationManagerProtocol {
    
    var location:CLLocation? {get}

}

extension CLLocationManager: LocationManagerProtocol {
}

class MockLocationManager: LocationManagerProtocol {

    var location:CLLocation? = CLLocation(latitude: 55.213448, longitude: 20.608194)

}
