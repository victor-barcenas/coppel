//
//  MostSelledCell.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

final class MostSelledCollectionCell: UICollectionViewCell, BaseCollectionCell {
    
    static let identifier = String(describing: MostSelledCollectionCell.self)
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var offerContainer: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var deliveryStack: UIStackView!
    @IBOutlet weak var cartButton: UIButton!
    private var offerView: TagView!
    private var onlineView: TagView!
    private var shippingImage: UIImageView!
    private var onlineImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if offerView != nil {
            offerView.removeFromSuperview()
            offerView = nil
        }
        if onlineView != nil {
            onlineView.removeFromSuperview()
            onlineView = nil
        }
        if shippingImage != nil {
            shippingImage.removeFromSuperview()
            shippingImage = nil
        }
        if onlineImage != nil {
            onlineImage.removeFromSuperview()
            onlineImage = nil
        }
    }
    
    func configure(_ object: Codable) {
        guard let mostSelled = object as? MostSelled else {
            return
        }
        image.download(from: mostSelled.image)
        image.contentMode = .scaleAspectFill
        title.text = mostSelled.title
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        setPrice(mostSelled.price, offerPrice: mostSelled.discountPrice)
        setOfferPrice(mostSelled.discountPrice)
        setCartButton()
        setDeliveryStack(isFreeDelivery: mostSelled.freeDelivery,
                         isOnlineExclusive: mostSelled.isOnlineExclusive)
        setOfferContainer(mostSelled.isOffer,
                          isOnlineExclusive: mostSelled.isOnlineExclusive)
        shadowView.setShadow()
    }
    
    private func setDeliveryStack(isFreeDelivery: Bool, isOnlineExclusive: Bool) {
        deliveryStack.spacing = 8
        deliveryStack.distribution = .fillEqually
        if (isFreeDelivery && shippingImage == nil) {
            shippingImage = UIImageView()
            shippingImage.image = UIImage.appImage(.shipping)
                .withRenderingMode(.alwaysTemplate)
            shippingImage.tintColor = UIColor.appColor(.iconGreen)
            shippingImage.contentMode = .scaleAspectFit
            
            shippingImage.translatesAutoresizingMaskIntoConstraints = false
            
            deliveryStack.addArrangedSubview(shippingImage)
            NSLayoutConstraint.activate([
                shippingImage.widthAnchor.constraint(equalToConstant: 24),
                shippingImage.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
        
        if (isOnlineExclusive && onlineImage == nil) {
            onlineImage = UIImageView()
            onlineImage.image = UIImage.appImage(.shoppingBag)
                .withRenderingMode(.alwaysTemplate)
            onlineImage.tintColor = UIColor.appColor(.iconBlue)
            onlineImage.contentMode = .scaleAspectFit
            onlineImage.translatesAutoresizingMaskIntoConstraints = false
            
            deliveryStack.addArrangedSubview(onlineImage)
            NSLayoutConstraint.activate([
                onlineImage.widthAnchor.constraint(equalToConstant: 24),
                onlineImage.heightAnchor.constraint(equalToConstant: 24)
            ])
        } else if (!isOnlineExclusive && onlineImage == nil) {
            onlineImage = UIImageView()
            onlineImage.image = UIImage.appImage(.store)
                .withRenderingMode(.alwaysTemplate)
            onlineImage.tintColor = UIColor.appColor(.iconGreen)
            onlineImage.contentMode = .scaleAspectFit
            onlineImage.translatesAutoresizingMaskIntoConstraints = false
            
            deliveryStack.addArrangedSubview(onlineImage)
            NSLayoutConstraint.activate([
                onlineImage.widthAnchor.constraint(equalToConstant: 24),
                onlineImage.heightAnchor.constraint(equalToConstant: 24)
            ])
        }
        
        
    }
    
    private func setCartButton() {
        cartButton.setBorder(color: UIColor.appColor(.iconBlue))
        cartButton.rounded()
        cartButton.tintColor = UIColor.appColor(.iconBlue)
        cartButton.setImage(UIImage.appImage(.cart).withRenderingMode(.alwaysTemplate),
                            for: .normal)
    }
    
    private func setPrice(_ price: String, offerPrice: String) {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        let priceNumber = NSNumber(floatLiteral: Double(price) ?? 0.0)
        let offerPriceNumber = NSNumber(floatLiteral: Double(offerPrice) ?? 0.0)
        if let formattedAmount = formatter.string(from: priceNumber) {
            self.price.text = "\(formattedAmount)"
            self.price.textColor = offerPriceNumber.doubleValue > 0 ? UIColor.offerTitleRed : .black
        }
    }
    
    private func setOfferPrice(_ offerPrice: String) {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        let offerPriceNumber = NSNumber(floatLiteral: Double(offerPrice) ?? 0.0)
        guard offerPriceNumber.doubleValue > 0 else {
            self.offerPrice.isHidden = true
            return
        }
        self.offerPrice.isHidden = false
        if let formattedAmount = formatter.string(from: offerPriceNumber) {
            self.offerPrice.attributedText = "\(formattedAmount)".strikeThrough()
        }
    }
    
    private func setOfferContainer(_ isOffer: Bool,
                                   isOnlineExclusive: Bool) {
        if (isOffer && offerView == nil) {
            offerView = TagView(tagType: .offer)
            offerView.translatesAutoresizingMaskIntoConstraints = false
            
            offerContainer.addSubview(offerView)
            offerView.contentMode = .center
            NSLayoutConstraint.activate([
                offerView.widthAnchor.constraint(equalToConstant: TagType.offer.width),
                offerView.heightAnchor.constraint(equalToConstant: 20),
                offerView.leadingAnchor.constraint(equalTo: offerContainer.leadingAnchor)
            ])
        }
        
        if (isOnlineExclusive && onlineView == nil) {
            onlineView = TagView(tagType: .online)
            onlineView.translatesAutoresizingMaskIntoConstraints = false
            
            offerContainer.addSubview(onlineView)
            NSLayoutConstraint.activate([
                onlineView.widthAnchor.constraint(equalToConstant: TagType.online.width),
                onlineView.heightAnchor.constraint(equalToConstant: 20)
            ])
            if offerView != nil {
                onlineView.leadingAnchor.constraint(equalTo: offerView.trailingAnchor,
                                                          constant: 8).isActive = true
            }
        } else if !isOnlineExclusive {
            onlineView = nil
        }
    }
}
