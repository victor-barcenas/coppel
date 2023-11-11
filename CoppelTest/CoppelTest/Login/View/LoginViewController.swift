//
//  ViewController.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: PasswordField!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubViews()
    }

    private func setupSubViews() {
        emailField.addBottomBorder()
        passwordField.addBottomBorder()
        loginbutton.roundCorners()
        createAccountButton.roundCorners()
        createAccountButton.setBorder(color: UIColor.appColor(.blueMain)!)
    }
}

