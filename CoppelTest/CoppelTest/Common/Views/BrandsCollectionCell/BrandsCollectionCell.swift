//
//  BrandsCollectionCell.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import UIKit

final class BrandsCollectionCell: UICollectionViewCell, BaseCollectionCell {
    
    static let identifier: String = String(String(describing: BrandsCollectionCell.self))
    
    @IBOutlet weak var brandLogo: UIImageView!
    
    func configure(_ object: Codable) {
        guard let brand = object as? Brand else {
            return
        }
        brandLogo.contentMode = .scaleAspectFit
        brandLogo.backgroundColor = .white
        brandLogo.rounded()
        brandLogo.download(from: brand.image)
    }
}
