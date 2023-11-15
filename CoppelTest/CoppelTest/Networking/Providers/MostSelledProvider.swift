//
//  MostSelledProvideer.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import FirebaseFirestore

protocol MostSelledProviderP {
    func getMostSelled(_ completion: @escaping(Result<[MostSelled], ProviderError>) -> Void)
}

final class MostSelledProvider: BaseProvider, MostSelledProviderP {
    
    static let name = "más vendidos"
    
    func getMostSelled(_ completion: @escaping(Result<[MostSelled], ProviderError>) -> Void) {
        db.collection(Database.mostSelled).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.downloadError(MostSelledProvider.name)))
            } else {
                var mostSelledList: [MostSelled] = []
                for document in snapshot!.documents {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
                        let mostSelled = try JSONDecoder().decode(MostSelled.self, from: jsonData)
                        mostSelledList.append(mostSelled)
                    } catch (let error) {
                        print(error.localizedDescription)
                        completion(.failure(.serializeError(CategoriesProvider.name)))
                    }
                }
                completion(.success(mostSelledList))
            }
        }
    }
}
