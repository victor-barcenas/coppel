//
//  HoomeProtocols.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

protocol HomePresenterProtocol: AnyObject {
    var view: UIViewController? { get set }
    var router: HomeRouterProtocol { get set }
    var interactor: HomeInteractorProtocol { get set }
    
    func viewDidLoad(view: UIViewController)
}

protocol HomeInteractorProtocol {
    var homeInteractorInput: HomeInteractorInputProtocol { get set }
    var output: HomeInteractorOutputProtocol? { get set }
    
    func getCategories()
    func getMostSelled()
    func getBrands()
}

protocol HomeInteractorInputProtocol: AnyObject {
    var categoriesProvider: CategoriesProvider { get set }
    var mostSelledProvider: MostSelledProvider { get set }
    var brandsProvider: BrandProvider { get set }
    
    func getCategories(_ completion: @escaping(Result<[Category], ProviderError>) -> Void)
    func getBrands(_ completion: @escaping(Result<[Brand], ProviderError>) -> Void)
    func getMostSelled(_ completion: @escaping(Result<[MostSelled], ProviderError>) -> Void)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func getCategoriesSucceed(_ categories: [Category])
    func getBrandsSucceed(_ brands: [Brand])
    func getMostSelledSucceed(_ mostSelled: [MostSelled])
    func getProviderDidFail(with error: ProviderError)
}

protocol HomeRouterProtocol: AnyObject {}
