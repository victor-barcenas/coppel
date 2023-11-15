//
//  BrandsProvider.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import FirebaseFirestore

protocol BrandProviderP {
    func getBrands(_ completion: @escaping(Result<[Brand], ProviderError>) -> Void)
}

final class BrandProvider: BaseProvider, BrandProviderP {
    
    static let name = "marcas"
    
    func getBrands(_ completion: @escaping(Result<[Brand], ProviderError>) -> Void) {
        db.collection(Database.brands).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.downloadError(BrandProvider.name)))
            } else {
                var brands: [Brand] = []
                for document in snapshot!.documents {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
                        let brand = try JSONDecoder().decode(Brand.self, from: jsonData)
                        brands.append(brand)
                    } catch (let error) {
                        print(error.localizedDescription)
                        completion(.failure(.serializeError(BrandProvider.name)))
                    }
                }
                completion(.success(brands))
            }
        }
    }
}
