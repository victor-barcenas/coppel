//
//  HomeViewBuilder.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

final class HomeViewBuilder {
    
    private init() {}
    
    static func build() -> HomeView {
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
