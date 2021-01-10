//
//  ChartUIView.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 1/10/21.
//

import SwiftUI

struct ChartUIView: View {
    var body: some View {
        HStack(spacing: 20) {
            BarGroupingView()
            BarGroupingView()
            BarGroupingView()
        }
    }
}

struct BarGroupingView: View {
    var body: some View {
        HStack (alignment: .bottom, spacing: 2){
            BarView(hexColor: "#EA1DBD", height: 10)
            BarView(hexColor: "#2C7FFB", height: 50)
            BarView(hexColor: "#4FFF60", height: 20)
            BarView(hexColor: "#FFAA28", height: 80)
        }
    }
}

struct BarView: View {
    
    var hexColor : String
    var height : CGFloat
    
    init(hexColor: String, height: CGFloat) {
        self.hexColor = hexColor
        self.height = height
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(Color.init(hexStringToUIColor(hex: self.hexColor)))
                .frame(width: 12, height: self.height)
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

struct ChartUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChartUIView()
    }
}
