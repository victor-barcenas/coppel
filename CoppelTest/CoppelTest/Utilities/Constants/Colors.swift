//
//  Colors.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

enum Colors: String {
    case blueMain
}

extension UIColor {
    static func appColor(_ color: Colors) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}
