//
//  ProviderError.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import Foundation

enum ProviderError: Error, LocalizedError {
    case downloadError(String)
    case serializeError(String)
    
    public var errorDescription: String? {
        switch self {
        case .downloadError(let providerName):
            return "Ocurrió un error al descargar las \(providerName)"
        case .serializeError(let providerName):
            return "Los datos recibidos de \(providerName) tienen un formato incorrecto"
        }
    }
}
