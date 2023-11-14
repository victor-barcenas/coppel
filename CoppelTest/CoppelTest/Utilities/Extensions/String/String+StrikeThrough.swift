//
//  String+StrikeThrough.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import Foundation
import UIKit

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, 
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
