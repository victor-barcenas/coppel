//
//  HomePresenter.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

final class HomePresenter: HomePresenterProtocol {
    
    internal weak var view: UIViewController?
    internal var router: HomeRouterProtocol
    internal var interactor: HomeInteractorProtocol
    private var homeView: HomeView? {
        guard let homeView = view as? HomeView else {
            return nil
        }
        return homeView
    }
    private var didFinishLoadCategories: Bool = false
    private var didFinishLoadBrands: Bool = false
    private var didFinishLoadMostSelled: Bool = false
    
    init(router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.router = router
        self.interactor = interactor
        self.interactor.output = self
    }
    
    func viewDidLoad(view: UIViewController) {
        self.view = view
        homeView?.startLoading(with: "Cargando")
        interactor.getCategories()
        interactor.getBrands()
        interactor.getMostSelled()
    }
    
    func stopLoading() {
        if didFinishLoadBrands && didFinishLoadCategories && didFinishLoadMostSelled {
            didFinishLoadBrands = false
            didFinishLoadCategories = false
            didFinishLoadMostSelled = false
            homeView?.stopLoading()
        }
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func getCategoriesSucceed(_ categories: [Category]) {
        let itemSize = CGSize(width: 108, height: 135)
        homeView?.categoryCollectionView.configure(data: categories,
                                                   itemIdentifier: CategoryCollectionCell.identifier,
                                                   itemSize: itemSize)
        didFinishLoadCategories = true
        stopLoading()
    }
    
    func getBrandsSucceed(_ brands: [Brand]) {
        let itemSize = CGSize(width: 75, height: 75)
        homeView?.brandsCollectionView.configure(data: brands,
                                                 itemIdentifier: BrandsCollectionCell.identifier,
                                                 itemSize: itemSize)
        didFinishLoadBrands = true
        stopLoading()
    }
    
    func getMostSelledSucceed(_ mostSelled: [MostSelled]) {
        let itemSize = CGSize(width: 228, height: 360)
        homeView?.mostSelledCollectionView.configure(data: mostSelled,
                                                 itemIdentifier: MostSelledCollectionCell.identifier,
                                                 itemSize: itemSize)
        didFinishLoadMostSelled = true
        stopLoading()
    }
    
    func getProviderDidFail(with error: ProviderError) {
        view?.showMessage(error.localizedDescription)
    }
    
    
}
