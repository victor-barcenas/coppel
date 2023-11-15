//
//  CategoryCollectionCell.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

final class CategoryCollectionCell: UICollectionViewCell, BaseCollectionCell {
        
    static let identifier = String(describing: CategoryCollectionCell.self)
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var title: UILabel!
    
    func configure(_ object: Codable) {
        guard let category = object as? Category else {
            return
        }
        image.download(from: category.icon)
        title.text = category.description
        image.rounded()
        imageContainer.rounded()
        imageContainer.setShadow()
    }
}
