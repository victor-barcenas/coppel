//
//  LoginPresenter.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

final class LoginPresenter: LoginViewPresenterProtocol {
    private weak var view: UIViewController?
    private var router: LoginRouterProtocol
    private var interactor: LoginInteractorProtocol
    
    init(router: LoginRouterProtocol, interactor: LoginInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        self.interactor.output = self
    }
    
    func viewDidLoad(view: UIViewController) {
        self.view = view
    }
    
    func performLogin(email: String?, password: String?) {
        guard let email = email, let password = password, !email.isEmpty,
        !password.isEmpty else {
            view?.showMessage(LoginError.emptyCredetentials.localizedDescription)
            return
        }
        interactor.login(withEmail: email, password: password)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func loginSucceed(_ user: User) {
        print(user)
    }
    
    func loginDidFail(with error: LoginError) {
        view?.showMessage(error.localizedDescription)
    }
    
    
}
