//
//  LoginProtocol.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

protocol LoginViewPresenterProtocol: AnyObject {
    func viewDidLoad(view: UIViewController)
}

protocol LoginInteractorProtocol {
    var loginInteractorInput: LoginInteractorInputProtocol { get set }
    var output: LoginInteractorOutputProtocol? { get set }
    
    func login(withEmail email: String, password: String)
}

protocol LoginInteractorInputProtocol: AnyObject {
    var authManager: AuthManager { get set }
    
    func login(withEmail email: String, password: String,
               completion: @escaping(Result<User, LoginError>) -> Void)
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func loginSucceed(_ user: User)
    func loginDidFail(with error: LoginError)
}

protocol LoginRouterProtocol: AnyObject {
    func showHome()
}
