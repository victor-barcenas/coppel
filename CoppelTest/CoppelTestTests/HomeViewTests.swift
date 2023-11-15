//
//  HomeViewTests.swift
//  CoppelTestTests
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import XCTest

final class HomeViewTests: XCTestCase {
    
    var expectation: XCTestExpectation?
    var categories: [Category]!
    var mostSelledList: [MostSelled]!
    var brands: [Brand]!
    var providerError: ProviderError!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        categories = nil
        mostSelledList = nil
        brands = nil
        providerError = nil
        expectation = nil
    }
    
    final class HomeViewBuilderMock: HomeViewBuilderP {
        
        private init() {}
        
        static func build() -> UIViewController {
            let router = HomeRouter()
            let interactor = HomeInteractor()
            let presenter = HomePresenter(router: router, interactor: interactor)
            let storyboard = UIStoryboard.init(name: "HomeView", bundle: nil)
            let homeView = storyboard.instantiateViewController(withIdentifier: "HomeView")
            return homeView
        }
    }
    
    func testInitHomeView() {
        let homeView = HomeViewBuilderMock.build()
        XCTAssertNotNil(homeView)
    }
    
    class CategoriesProviderMock: CategoriesProviderP {
        func getCategories(_ completion: @escaping (Result<[Category], ProviderError>) -> Void) {
            let categories = [
                Category(description: "test category 1", icon: "icon"),
                Category(description: "test category 2", icon: "icon2"),
                Category(description: "test category 3", icon: "icon3")
            ]
            completion(.success(categories))
        }
    }
    
    class MostSelledProviderMock: MostSelledProviderP {
        func getMostSelled(_ completion: @escaping (Result<[MostSelled], ProviderError>) -> Void) {
            let mostSelledList = [
                MostSelled(discountPrice: "10", image: "image", isOffer: true,
                           isOnlineExclusive: false, price: "20", title: "title",
                           freeDelivery: false),
                MostSelled(discountPrice: "10", image: "image", isOffer: true,
                           isOnlineExclusive: false, price: "20", title: "title",
                           freeDelivery: false),
                MostSelled(discountPrice: "10", image: "image", isOffer: true,
                           isOnlineExclusive: false, price: "20", title: "title",
                           freeDelivery: false)
            ]
            completion(.success(mostSelledList))
        }
    }
    
    class BrandsProviderMock: BrandProviderP {
        func getBrands(_ completion: @escaping (Result<[Brand], ProviderError>) -> Void) {
            let brands = [
                Brand(image: "image1"),
                Brand(image: "image2"),
                Brand(image: "image3")
            ]
            completion(.success(brands))
        }
    }
    class HomeInteractorInputMock: HomeInteractorInputProtocol {
        var categoriesProvider: CategoriesProviderP
        var mostSelledProvider: MostSelledProviderP
        var brandsProvider: BrandProviderP
        var shouldReturnError = false
        
        init() {
            categoriesProvider = CategoriesProviderMock()
            mostSelledProvider = MostSelledProviderMock()
            brandsProvider = BrandsProviderMock()
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
    
    class SuccessHomeInteractorMock: HomeInteractorProtocol {
        var homeInteractorInput: HomeInteractorInputProtocol
        var output: HomeInteractorOutputProtocol?
        
        init(output: HomeInteractorOutputProtocol? = nil) {
            self.homeInteractorInput = HomeInteractorInputMock()
            self.output = output
        }
        
        func getCategories() {
            homeInteractorInput.getCategories { [weak self] result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    switch result {
                    case .success(let categories):
                        self?.output?.getCategoriesSucceed(categories)
                    case .failure(let failure):
                        self?.output?.getProviderDidFail(with: failure)
                    }
                }
            }
        }
        
        func getMostSelled() {
            homeInteractorInput.getMostSelled { [weak self] result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    switch result {
                    case .success(let mostSelledList):
                        self?.output?.getMostSelledSucceed(mostSelledList)
                    case .failure(let failure):
                        self?.output?.getProviderDidFail(with: failure)
                    }
                }
            }
        }
        
        func getBrands() {
            homeInteractorInput.getBrands { [weak self] result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    switch result {
                    case .success(let brands):
                        self?.output?.getBrandsSucceed(brands)
                    case .failure(let failure):
                        self?.output?.getProviderDidFail(with: failure)
                    }
                }
            }
        }
        
        
    }
    
    class FailHomeInteractorMock: HomeInteractorProtocol {
        var homeInteractorInput: HomeInteractorInputProtocol = HomeInteractorInputMock()
        var output: HomeInteractorOutputProtocol?
        
        func getCategories() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.output?.getProviderDidFail(with: .downloadError(CategoriesProvider.name))
            }
        }
        
        func getMostSelled() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.output?.getProviderDidFail(with: .downloadError(MostSelledProvider.name))
            }
        }
        
        func getBrands() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.output?.getProviderDidFail(with: .downloadError(BrandProvider.name))
            }
        }
    }
    
    
    func testShowMostSelledSuccess() throws {
        let succesHomeInteractor = SuccessHomeInteractorMock(output: self)
        succesHomeInteractor.getMostSelled()
        
        expectation = expectation(description: "GetMostSelled")
        waitForExpectations(timeout: 3)
        
        let result = try XCTUnwrap(mostSelledList)
        XCTAssertTrue(result.count > 0)
    }
    
    func testDontShowSelled() throws {
        let succesHomeInteractor = FailHomeInteractorMock()
        succesHomeInteractor.output = self
        succesHomeInteractor.getMostSelled()
        
        expectation = expectation(description: "GetMostSelledFail")
        waitForExpectations(timeout: 3)
        
        let result = try XCTUnwrap(providerError)
        XCTAssertNotNil(result)
    }
    
    func testShowCategoriesSuccess() throws {
        let succesHomeInteractor = SuccessHomeInteractorMock(output: self)
        succesHomeInteractor.getCategories()
        
        expectation = expectation(description: "GetCategories")
        waitForExpectations(timeout: 3)
        
        let result = try XCTUnwrap(categories)
        XCTAssertTrue(result.count > 0)
    }
    
    func testDontShowCategories() throws {
        let succesHomeInteractor = FailHomeInteractorMock()
        succesHomeInteractor.output = self
        succesHomeInteractor.getCategories()
        
        expectation = expectation(description: "GetCategoriesFail")
        waitForExpectations(timeout: 3)
        
        let result = try XCTUnwrap(providerError)
        XCTAssertNotNil(result)
    }
    
    func testShowBrandsSuccess() throws {
        let succesHomeInteractor = SuccessHomeInteractorMock(output: self)
        succesHomeInteractor.getBrands()
        
        expectation = expectation(description: "GetCategories")
        waitForExpectations(timeout: 3)
        
        let result = try XCTUnwrap(brands)
        XCTAssertTrue(result.count > 0)
    }
    
    func testDontShowBrands() throws {
        let succesHomeInteractor = FailHomeInteractorMock()
        succesHomeInteractor.output = self
        succesHomeInteractor.getBrands()
        
        expectation = expectation(description: "GetCategoriesFail")
        waitForExpectations(timeout: 3)
        
        let result = try XCTUnwrap(providerError)
        XCTAssertNotNil(result)
    }
}

extension HomeViewTests: HomeInteractorOutputProtocol {
    func getCategoriesSucceed(_ categories: [Category]) {
        self.categories = categories
        expectation?.fulfill()
    }
    
    func getBrandsSucceed(_ brands: [Brand]) {
        self.brands = brands
        expectation?.fulfill()
    }
    
    func getMostSelledSucceed(_ mostSelled: [MostSelled]) {
        mostSelledList = mostSelled
        expectation?.fulfill()
    }
    
    func getProviderDidFail(with error: ProviderError) {
        providerError = error
        expectation?.fulfill()
    }
}

