//
//  LocationManagerTests.swift
//  GeoTriggerTests
//
//  Created by Vijay Selvaraj on 1/5/21.
//

import XCTest
import CoreLocation
@testable import GeoTrigger

class LocationManagerTests: XCTestCase {

    let mockLocationManager : MockLocationManager = MockLocationManager()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
                
        //TODO: Setup region's                
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }                

    func testDidUpdateLocations() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // let locationManager = LocationManager.shared
        
        // let mockLocationManager = MockLocationManager()
        
        // XCTAssertEqual(locationManager.location, mockLocationManager.location)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
