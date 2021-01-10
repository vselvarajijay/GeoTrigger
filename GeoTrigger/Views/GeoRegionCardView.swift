//
//  GeoRegionCardView.swift
//  GeoTrigger
//
//  Created by Vijay Selvaraj on 1/10/21.
//

import SwiftUI

struct GeoRegionCardView: View {
    
    var hexColor : String
    init(hexColor: String) {
        self.hexColor = hexColor
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(Color.init(hexStringToUIColor(hex: self.hexColor)))
            .frame(width: 100, height: 100)
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

struct GeoRegionCardView_Previews: PreviewProvider {
    static var previews: some View {
        GeoRegionCardView(hexColor: "000000")
    }
}
