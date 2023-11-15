//
//  RealtimeProvider.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import FirebaseRemoteConfig

typealias RealTimeNotification<T> = (type: RealTimeKeys, value:T)

final class RealtimeProvider {
    private var remoteConfig: RemoteConfig!
    
    init() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func startListeningForUpdates() {
        remoteConfig.fetch { [weak self] status, error in
            if status == .success {
                self?.remoteConfig.activate(completion: { [weak self] changed, error in
                    let localAppVersion = Double(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0") ?? 1.0
                    let remoteAppVersion = self?.remoteConfig.configValue(forKey: RealTimeKeys.appVersion.name)
                    if remoteAppVersion?.numberValue.doubleValue ?? 0.0 > localAppVersion {
                        let realtimeNotification = RealTimeNotification(type: .appVersion,
                                                                        value: remoteAppVersion)
                        NotificationCenter.default.post(name: RealTimeKeys.realTimeUpdateNotification,
                                                        object: realtimeNotification)
                    }
                })
                
            }
        }
        remoteConfig.addOnConfigUpdateListener { [weak self] configUpdate, error in
            self?.remoteConfig.fetch { [weak self] status, error in
                if status == .success {
                    self?.remoteConfig.activate(completion: { [weak self] changed, error in
                        let localAppVersion = Double(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0") ?? 1.0
                        let remoteAppVersion = self?.remoteConfig.configValue(forKey: RealTimeKeys.appVersion.name)
                        if remoteAppVersion?.numberValue.doubleValue ?? 0.0 > localAppVersion {
                            let realtimeNotification = RealTimeNotification(type: .appVersion,
                                                                            value: remoteAppVersion)
                            NotificationCenter.default.post(name: RealTimeKeys.realTimeUpdateNotification,
                                                            object: realtimeNotification)
                        } else {
                            guard let configUpdate, error == nil else {
                                print("Error listening for config updates: \(String(describing: error))")
                                return
                            }
                            for realTimeKey in RealTimeKeys.allCases {
                                guard configUpdate.updatedKeys.contains(realTimeKey.name) else {
                                    continue
                                }
                                guard let value = self?.remoteConfig.configValue(forKey: realTimeKey.name) else {
                                    continue
                                }
                                let realtimeNotification = RealTimeNotification(type: realTimeKey,
                                                                                value: value)
                                NotificationCenter.default.post(name: RealTimeKeys.realTimeUpdateNotification,
                                                                object: realtimeNotification)
                                return
                            }
                        }
                    })
                        
                }
            }
        }
    }
}

