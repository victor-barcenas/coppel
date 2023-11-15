//
//  ViewController.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit

class LoginView: UIViewController, ActivityIndicatable {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: PasswordField!
    @IBOutlet weak var loginbutton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    private var presenter: LoginPresenter!
    
    init?(coder: NSCoder, presenter: LoginPresenter) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
        presenter.viewDidLoad(view: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSubViews()
    }

    private func setupSubViews() {
        emailField.addBottomBorder()
        passwordField.addBottomBorder()
        loginbutton.roundCorners()
        createAccountButton.roundCorners()
        createAccountButton.setBorder(color: UIColor.appColor(.blueMain))
    }

    @IBAction func loginAction(_ sender: Any) {
        presenter.performLogin(email: emailField.text,
                               password: passwordField.text)
    }
}

