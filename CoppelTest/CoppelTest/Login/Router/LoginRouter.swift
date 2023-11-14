//
//  LoginRouter.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

final class LoginRouter: LoginRouterProtocol {
    func showHome(view: UIViewController) {
        let homeView = HomeViewBuilder.build()
        //Crating a new nav stack
        let navController = UINavigationController(rootViewController: homeView)
        view.transition(to: navController)
    }
}
