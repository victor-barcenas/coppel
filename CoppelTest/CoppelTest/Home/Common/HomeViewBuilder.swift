//
//  HomeViewBuilder.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

protocol HomeViewBuilderP {
    static func build() -> UIViewController
}

final class HomeViewBuilder: HomeViewBuilderP {
    
    private init() {}
    
    static func build() -> UIViewController {
        let router = HomeRouter()
        let interactor = HomeInteractor()
        let presenter = HomePresenter(router: router, interactor: interactor)
        let homeView = UIStoryboard(name: "HomeView", bundle: .main)
            .instantiateViewController(identifier: "HomeView", creator: { coder -> HomeView? in
                HomeView(coder: coder, presenter: presenter)
        })
        return homeView
    }
}
