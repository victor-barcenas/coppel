//
//  LoginPresenter.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

final class LoginPresenter: LoginViewPresenterProtocol {
    internal weak var view: UIViewController?
    internal var router: LoginRouterProtocol
    internal var interactor: LoginInteractorProtocol
    
    private var loginView: LoginView? {
        guard let loginView = view as? LoginView else {
            return nil
        }
        return loginView
    }
    
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
        loginView?.startLoading(with: "Inciando sesión")
        interactor.login(withEmail: email, password: password)
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func loginSucceed(_ user: User) {
        guard let view = self.view else {
            return
        }
        loginView?.stopLoading()
        router.showHome(view: view)
    }
    
    func loginDidFail(with error: LoginError) {
        loginView?.stopLoading()
        view?.showMessage(error.localizedDescription)
    }
    
    
}
