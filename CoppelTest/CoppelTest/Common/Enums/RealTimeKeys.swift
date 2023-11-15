//
//  RealTimeKeys.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import Foundation

enum RealTimeKeys: CaseIterable {
    
    static let realTimeUpdateNotification: Notification.Name = Notification.Name(rawValue: "RealTimeUpdate")

    case appVersion
    case shouldShowPromoBanner
    case shouldShowUnderMaintainanceScreen
    
    var name: String {
        switch self {
        case .appVersion:
            return "appVersion"
        case .shouldShowPromoBanner:
            return "shouldShowPromoBanner"
        case .shouldShowUnderMaintainanceScreen:
            return "shouldShowUnderMaintainanceScreen"
        }
    }
    
    var description: String {
        switch self {
        case .shouldShowUnderMaintainanceScreen:
            return "La aplicación se encuentra en mantenimiento, intenta más tarde."
        case .appVersion:
            return "Favor de actualizar la aplicación"
        default:
            return ""
        }
    }
    
}
