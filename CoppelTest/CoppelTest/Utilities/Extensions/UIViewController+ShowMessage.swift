//
//  UIViewController.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

extension UIViewController {
    func showMessage(_ message: String, title: String? = nil) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
