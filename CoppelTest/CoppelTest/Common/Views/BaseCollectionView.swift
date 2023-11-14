//
//  BrandsCollectionView.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import UIKit

protocol BaseCollectionCell where Self: UICollectionViewCell {
    func configure(_ object: Codable)
}

protocol BaseCollectionViewP where Self: UICollectionView {
    var objectList: [Codable] { get set }
    var itemIdentifier: String { get set }
    
    func configure(data: [Codable], itemIdentifier: String, itemSize: CGSize)
}

final class BaseCollectionView: UICollectionView, BaseCollectionViewP {
    internal var objectList: [Codable] = []
    internal var itemIdentifier: String = ""
    
    func configure(data: [Codable], itemIdentifier: String, itemSize: CGSize) {
        self.objectList = data
        self.itemIdentifier = itemIdentifier
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = itemSize
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 1
        self.collectionViewLayout = flowLayout
        dataSource = self
        reloadData()
    }
}

extension BaseCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return objectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt
                        indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemIdentifier,
                                                            for: indexPath) as? BaseCollectionCell else {
            return UICollectionViewCell()
        }
        let object = objectList[indexPath.item]
        cell.configure(object)
        return cell
    }
}
