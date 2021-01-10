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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    var body: some View {
        NavigationView {
            VStack{
                ChartUIView()
                Spacer()
                HStack {
                    GeoRegionCardView(hexColor: "#F6F6F6", statusColor: "#4FFF60")
                    GeoRegionCardView(hexColor: "#F6F6F6", statusColor: "#EA1DBD")
                }
                HStack {
                    GeoRegionCardView(hexColor: "#F6F6F6", statusColor: "#2C7FFB")
                    GeoRegionCardView(hexColor: "#F6F6F6", statusColor: "#FFAA28")
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavToolbarItem()
                }
            }
        }

    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
        
}


struct NavToolbarItem: View {
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: -5) {
                    Circle().fill(Color.init(hexStringToUIColor(hex: "#EC4C4C")))
                        .frame(width: 15.0, height: 15.0)
                    Circle().fill(Color.init(hexStringToUIColor(hex: "#F28657")))
                        .frame(width: 15.0, height: 15.0)
                    Circle().fill(Color.init(hexStringToUIColor(hex: "#F2AF58")))
                        .frame(width: 15.0, height: 15.0)
                }
                Text("LOCATION ANALYTICS").font(.custom("Helvetica Neue", size: 10)).fontWeight(.bold)
                Spacer()
            }
            Spacer()
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


struct LocationDebuggingView: View {
    
    let appConfig = AppConfig.config
    @ObservedObject var locationManager = LocationManager.shared
    @ObservedObject var notificationCenter = NotificationCenter.shared
    
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
