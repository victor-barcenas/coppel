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
    case cart
    case shipping
    case shoppingBag
    case store
    case maintenance
    case appUpdate
}

extension UIImage {
    static func appImage(_ image: Images) -> UIImage {
        return UIImage(named: image.rawValue) ?? UIImage()
    }
}
