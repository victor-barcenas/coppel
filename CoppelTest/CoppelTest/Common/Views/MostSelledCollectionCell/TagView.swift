//
//  TagView.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

final class TagView: UIView {
    private var textLabel: UILabel!
    
    private var tagType: TagType = .none
    
    init(tagType: TagType) {
        self.tagType = tagType
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        backgroundColor = tagType.backgroundColor
        roundCorners()
        
        textLabel = UILabel()
        textLabel.font = UIFont(name: "SFProDisplay-Light",
                                size: 10.0)
        textLabel.text = tagType.rawValue
        textLabel.textColor = tagType.titleColor
        textLabel.textAlignment = .center
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.widthAnchor.constraint(equalToConstant: tagType.width),
            textLabel.heightAnchor.constraint(equalToConstant: 20),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
