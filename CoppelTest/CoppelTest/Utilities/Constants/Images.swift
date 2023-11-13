//
//  Images.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

enum Images: String {
    case showPassword
    case hidePassword
}

extension UIImage {
    static func appImage(_ image: Images) -> UIImage {
        return UIImage(named: image.rawValue) ?? UIImage()
    }
}
