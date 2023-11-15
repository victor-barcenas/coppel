//
//  UIVIew+BottomBorder.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

extension UIView {
    func addBottomBorder(color: UIColor = .lightGray, height: CGFloat = 1) {
        let bottomBorderLayer = CALayer()
        bottomBorderLayer.backgroundColor = color.cgColor
        bottomBorderLayer.frame = CGRect(x: 0, y: bounds.height - height,
                                         width: bounds.width, height: height)
        layer.addSublayer(bottomBorderLayer)
    }
    
    func setBorder(color: UIColor, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func roundCorners(radius: CGFloat = 5) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func rounded() {
        self.layer.cornerRadius = frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func setShadow() {
        clipsToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}
