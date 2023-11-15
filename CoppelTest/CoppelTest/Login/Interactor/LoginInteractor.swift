//
//  LoginInteractor.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import Foundation

final class LoginInteractorInput: LoginInteractorInputProtocol {
    var authProvider: AuthProviderP
    
    init() {
        authProvider = AuthProvider()
    }
    
    func login(withEmail email: String, password: String,
               completion: @escaping(Result<User, LoginError>) -> Void) {
        authProvider.login(withEmail: email, password: password) { result in
            completion(result)
        }
    }
}

final class LoginInteractor: LoginInteractorProtocol {
    
    var loginInteractorInput: LoginInteractorInputProtocol
    weak var output: LoginInteractorOutputProtocol?
    
    init() {
        loginInteractorInput = LoginInteractorInput()
    }
    
    func login(withEmail email: String, password: String) {
        loginInteractorInput.login(withEmail: email,
                                   password: password) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let user):
                self.output?.loginSucceed(user)
            case .failure(let error):
                self.output?.loginDidFail(with: error)
            }
        }
    }
}
