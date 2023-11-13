//
//  LoginVIewBuilder.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

final class LoginViewBuilder {
    
    static func build() -> LoginView {
        let router = LoginRouter()
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(router: router, interactor: interactor)
        let loginView = UIStoryboard(name: "LoginView", bundle: .main)
            .instantiateViewController(identifier: "LoginView", creator: { coder -> LoginView? in
                LoginView(coder: coder, presenter: presenter)
        })
        return loginView
    }
}
