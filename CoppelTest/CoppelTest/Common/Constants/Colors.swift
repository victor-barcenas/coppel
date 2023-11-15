//
//  Colors.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

enum Colors: String {
    case blueMain
    case iconGreen
    case iconBlue
    case offerBGGray
    case offerBGRed
    case offerTitleGray
    case offerTitleRed
}

extension UIColor {
    static func appColor(_ color: Colors) -> UIColor {
        return UIColor(named: color.rawValue) ?? .black
    }
}
