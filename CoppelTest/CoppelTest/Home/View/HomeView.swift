//
//  HomeView.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit
import FirebaseFirestore

class HomeView: UIViewController, ActivityIndicatable {
    
    @IBOutlet weak var categoryCollectionView: BaseCollectionView!
    @IBOutlet weak var mostSelledCollectionView: BaseCollectionView!
    @IBOutlet weak var brandsCollectionView: BaseCollectionView!
    
    private var presenter: HomePresenter!
    
    init?(coder: NSCoder, presenter: HomePresenter) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        presenter.viewDidLoad(view: self)
    }
}
    
