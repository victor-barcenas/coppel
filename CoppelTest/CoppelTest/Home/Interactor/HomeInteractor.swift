//
//  HomeInteractor.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import Foundation

final class HomeInteractorInput: HomeInteractorInputProtocol {
    var mostSelledProvider: MostSelledProvider
    var brandsProvider: BrandProvider
    var categoriesProvider: CategoriesProvider
    
    init() {
        categoriesProvider = CategoriesProvider()
        brandsProvider = BrandProvider()
        mostSelledProvider = MostSelledProvider()
    }
    
    func getCategories(_ completion: @escaping (Result<[Category], ProviderError>) -> Void) {
        categoriesProvider.getCategories { result in
            completion(result)
        }
    }
    
    func getBrands(_ completion: @escaping (Result<[Brand], ProviderError>) -> Void) {
        brandsProvider.getBrands { result in
            completion(result)
        }
    }
    
    func getMostSelled(_ completion: @escaping (Result<[MostSelled], ProviderError>) -> Void) {
        mostSelledProvider.getMostSelled { result in
            completion(result)
        }
    }
}

final class HomeInteractor: HomeInteractorProtocol {
    var homeInteractorInput: HomeInteractorInputProtocol
    weak var output: HomeInteractorOutputProtocol?
    
    init() {
        homeInteractorInput = HomeInteractorInput()
    }
    
    func getCategories() {
        homeInteractorInput.getCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.output?.getCategoriesSucceed(categories)
            case .failure(let error):
                self?.output?.getProviderDidFail(with: error)
            }
        }
    }
    
    func getMostSelled() {
        homeInteractorInput.getMostSelled { [weak self] result in
            switch result {
            case .success(let mostSelled):
                self?.output?.getMostSelledSucceed(mostSelled)
            case .failure(let error):
                self?.output?.getProviderDidFail(with: error)
            }
        }
    }
    
    func getBrands() {
        homeInteractorInput.getBrands { [weak self] result in
            switch result {
            case .success(let brands):
                self?.output?.getBrandsSucceed(brands)
            case .failure(let error):
                self?.output?.getProviderDidFail(with: error)
            }
        }
    }
}

