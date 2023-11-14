//
//  CategoriesManager.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import Foundation
import FirebaseFirestore

final class CategoriesProvider: BaseProvider {
    
    static let name = "categorías"
    
    func getCategories(_ completion: @escaping(Result<[Category], ProviderError>) -> Void) {
        db.collection(Database.categories).getDocuments { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(.downloadError(CategoriesProvider.name)))
            } else {
                var categories: [Category] = []
                for document in snapshot!.documents {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted)
                        let category = try JSONDecoder().decode(Category.self, from: jsonData)
                        categories.append(category)
                    } catch (let error) {
                        print(error.localizedDescription)
                        completion(.failure(.serializeError(CategoriesProvider.name)))
                    }
                }
                completion(.success(categories))
            }
        }
    }
}
