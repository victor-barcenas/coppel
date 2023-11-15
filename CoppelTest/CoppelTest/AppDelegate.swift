//
//  AppDelegate.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 11/11/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window:UIWindow?
    private var realtimeProvider: RealtimeProvider!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let loginViewController = LoginViewBuilder.build()
        let navController = UINavigationController(rootViewController: loginViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        configureRealtimeUpdates()
        return true
    }
    
    private func configureRealtimeUpdates() {
        realtimeProvider = RealtimeProvider()
        realtimeProvider.startListeningForUpdates()
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(executeRealtimeUpdate(notification:)),
                                               name: RealTimeKeys.realTimeUpdateNotification, object: nil)
    }
    
    @objc private func executeRealtimeUpdate(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let realTimeNotification = notification.object as? RealTimeNotification<Any> else {
                return
            }
            guard let maintenanceView = self?.window?.topViewController() as? MaintenanceView else {
                let storyboard = UIStoryboard(name: "MaintenanceView", bundle: nil)
                if let maintenanceView = storyboard.instantiateViewController(
                    withIdentifier: "MaintenanceView") as? MaintenanceView {
                    
                    maintenanceView.modalPresentationStyle = .overFullScreen
                    maintenanceView.realTimeNotification = realTimeNotification
                    self?.window?.topViewController()?.present(maintenanceView,
                                                               animated: true)
                }
                
                return
            }
            maintenanceView.realTimeNotification = realTimeNotification
            maintenanceView.configure()
        }
    }
}

