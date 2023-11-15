//
//  PasswordField.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

class PasswordField: UITextField {
    private var shouldHidePassword: Bool = true
    private var eyeButton: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    func configure() {
        isSecureTextEntry = true
        eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage.appImage(.hidePassword), for: .normal)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        eyeButton.addTarget(self, action: #selector(didTapEyeIcon), for: .primaryActionTriggered)
        rightView = eyeButton
        rightViewMode = .always
    }
    
    @objc func didTapEyeIcon() {
        shouldHidePassword = !shouldHidePassword
        isSecureTextEntry = shouldHidePassword
        let icon = shouldHidePassword ? UIImage.appImage(.hidePassword) : UIImage.appImage(.showPassword)
        eyeButton.setImage(icon, for: .normal)
    }
}
