//
//  CoppelTestUITests.swift
//  CoppelTestUITests
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import XCTest

final class CoppelTestUITests: XCTestCase {
    
    var app: XCUIApplication!
    var expectation: XCTestExpectation?
    var user: User?
    
    class MockAuthManager: AuthManager {
        override func login(withEmail email: String, password: String,
                   completion: @escaping(Result<User, LoginError>) -> Void) {
            if email == "user@test.com" &&  password == "Password123*" {
                completion(.success(User(email: email)))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    final class MockLoginInteractorInput: LoginInteractorInputProtocol {
        
        var authManager: AuthManager
        
        init() {
            authManager = MockAuthManager()
        }
        
        func login(withEmail email: String, password: String,
                   completion: @escaping(Result<User, LoginError>) -> Void) {
            authManager.login(withEmail: email, password: password) { result in
                completion(result)
            }
        }
    }
    
    final class MockLoginInteractor: LoginInteractorProtocol {
        
        var loginInteractorInput: LoginInteractorInputProtocol
        weak var output: LoginInteractorOutputProtocol?
        
        init() {
            loginInteractorInput = MockLoginInteractorInput()
        }
        
        func login(withEmail email: String, password: String) {
            loginInteractorInput.login(withEmail: email,
                                       password: password) { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let user):
                    self.output?.loginSucceed(user)
                case .failure(let error):
                    self.output?.loginDidFail(with: error)
                }
            }
        }
    }
    
    final class MockLoginPresenter: LoginViewPresenterProtocol {
        private var router: LoginRouterProtocol
        private var interactor: LoginInteractorProtocol
        
        init(router: LoginRouterProtocol, interactor: LoginInteractorProtocol) {
            self.router = router
            self.interactor = interactor
        }
        
        func viewDidLoad(view: UIViewController) {}
        
        func performLogin(email: String?, password: String?) {
            guard let email = email, let password = password, !email.isEmpty,
            !password.isEmpty else {
                return
            }
            interactor.login(withEmail: email, password: password)
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testEmptyCredentials() {
        app.buttons["Iniciar Sesión"].tap()
        XCTAssert(app.staticTexts[LoginError.emptyCredetentials.localizedDescription].waitForExistence(timeout: 3))
    }
    
    func testInvalidCredentials() {
        let emailField = app.textFields["Correo electrónico*"]
        emailField.tap()
        emailField.typeText("invalid_email")
        
        let passwordField = app.secureTextFields["Contraseña*"]
        passwordField.tap()
        passwordField.typeText("invalid_password")
        
        app.buttons["Iniciar Sesión"].tap()
        
        XCTAssert(app.staticTexts[LoginError.invalidCredentials.localizedDescription].waitForExistence(timeout: 3))
    }
    
    func testSuccessLogin() throws {
        let router = LoginRouter()
        let interactor = MockLoginInteractor()
        interactor.output = self
        let presenter = MockLoginPresenter(router: router, interactor: interactor)
        
        expectation = expectation(description: "Login")
        let email = "user@test.com"
        let password = "Password123*"
        presenter.performLogin(email: email, password: password)
        
        let emailField = app.textFields["Correo electrónico*"]
        emailField.tap()
        emailField.typeText(email)
        
        let passwordField = app.secureTextFields["Contraseña*"]
        passwordField.tap()
        passwordField.typeText(password)
        
        app.buttons["Iniciar Sesión"].tap()
        
        
        waitForExpectations(timeout: 3) // 4
        let result = try XCTUnwrap(user)
        XCTAssertNotNil(result)
    }
}


extension CoppelTestUITests: LoginInteractorOutputProtocol {
    func loginSucceed(_ user: User) {
        self.user = user
        expectation?.fulfill()
        expectation = nil
    }
    
    func loginDidFail(with error: LoginError) { }
}
