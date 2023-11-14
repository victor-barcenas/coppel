//
//  NavController+Transition.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import UIKit

extension UIViewController {
    
    func keyWindow() -> UIWindow {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first ?? UIWindow()
        return window
    }
    
    func transition(to controller: UIViewController) {
        let window = keyWindow()
        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
