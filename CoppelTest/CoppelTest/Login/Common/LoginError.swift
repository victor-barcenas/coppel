//
//  LoginError.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import Foundation

enum LoginError: Error, LocalizedError {
    case invalidCredentials
    case nilEmailReceived
    case emptyCredetentials
    
    public var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Usuario y/o contraseña incorrectos, intente de nuevo"
        case .nilEmailReceived:
            return "El usuario no tiene un correo asociado"
        case .emptyCredetentials:
            return "El correo y contraseña son obligatorios"
        }
    }
}
