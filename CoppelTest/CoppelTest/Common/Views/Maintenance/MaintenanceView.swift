//
//  MaintenanceView.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import UIKit
import FirebaseRemoteConfig

final class MaintenanceView: UIViewController {
    @IBOutlet weak var maintenanceImage: UIImageView!
    @IBOutlet weak var maintenanceLabel: UILabel!
    var realTimeNotification: RealTimeNotification<Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maintenanceImage.image = UIImage.appImage(.maintenance)
        configure()
    }
    
    func configure() {
        maintenanceLabel.textColor = UIColor.appColor(.blueMain)
        guard realTimeNotification != nil else {
            return
        }
        guard let value = realTimeNotification.value as? RemoteConfigValue else {
            return
        }
        
        switch realTimeNotification.type {
        case .shouldShowPromoBanner:
            guard realTimeNotification.type == .shouldShowPromoBanner else {
                dismiss(animated: true)
                return
            }
            guard let value = realTimeNotification.value as? RemoteConfigValue else {
                return
            }
            let jsonString: String = value.stringValue ?? ""
            var promoBanner: PromoBanner!
            if let jsonData = jsonString.data(using: .utf8) {
                do {
                    promoBanner = try JSONDecoder().decode(PromoBanner.self, from: jsonData)
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
            if promoBanner.shouldShowPromoBanner {
                maintenanceImage.download(from: promoBanner.image)
                maintenanceLabel.text = nil
            } else {
                dismiss(animated: true)
            }
        case .shouldShowUnderMaintainanceScreen:
            guard realTimeNotification.type == .shouldShowUnderMaintainanceScreen, 
                    value.boolValue else {
                dismiss(animated: true)
                return
            }
            maintenanceLabel.text = RealTimeKeys.shouldShowUnderMaintainanceScreen.description
            maintenanceImage.image = UIImage.appImage(.maintenance)
        case .appVersion:
            let localAppVersion = Double(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0") ?? 1.0
            let remoteAppVersion = value.numberValue
            guard remoteAppVersion.doubleValue > localAppVersion else {
                dismiss(animated: true)
                return
            }
            maintenanceLabel.text = RealTimeKeys.appVersion.description
            maintenanceImage.image = UIImage.appImage(.appUpdate)
        }
    }
    
    
}
