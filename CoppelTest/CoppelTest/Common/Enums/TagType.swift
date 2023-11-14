//
//  TagType.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

enum TagType: String {
    case none
    case offer = "Oferta"
    case online = "Exclusivo en línea"
    
    var width: CGFloat {
        switch self {
        case .none:
            return 0.0
        case .offer:
            return 65.00
        case .online:
            return 103.00
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .none:
            return .clear
        case .offer:
            return UIColor.appColor(.offerBGRed)
        case .online:
            return UIColor.appColor(.offerBGGray)
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .none:
            return .clear
        case .offer:
            return UIColor.appColor(.offerTitleRed)
        case .online:
            return UIColor.appColor(.offerTitleGray)
        }
    }
}
