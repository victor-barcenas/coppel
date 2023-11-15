//
//  AuthProvider.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import Foundation
import FirebaseAuth

protocol AuthProviderP {
    func login(withEmail email: String, password: String,
               completion: @escaping(Result<User, LoginError>) -> Void)
}

class AuthProvider: AuthProviderP {
    func login(withEmail email: String, password: String,
               completion: @escaping(Result<User, LoginError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard let _ = error else {
                if let email = authResult?.user.email {
                    completion(.success(User(email: email)))
                } else {
                    completion(.failure(.nilEmailReceived))
                }
                return
            }
            completion(.failure(.invalidCredentials))
        }
    }
}
