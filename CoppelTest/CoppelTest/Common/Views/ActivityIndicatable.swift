//
//  ActivityIndicatable.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 14/11/23.
//

import UIKit

protocol ActivityIndicatable where Self: UIViewController {
    var alert: UIView! { get set }
    func startLoading(with message: String)
    func stopLoading(_ handler: (()->Void)?)
}

fileprivate struct ActivityAssociatedKeys {
    static var activityKey = "kActivityIndicatorKey"
}

extension ActivityIndicatable {
    var alert: UIView! {
        get {
            let assocObj = objc_getAssociatedObject(self, &ActivityAssociatedKeys.activityKey)
            return assocObj as? UIView
        }
        set {
            objc_setAssociatedObject(self, &ActivityAssociatedKeys.activityKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func startLoading(with message: String = "") {
        alert = UIView(frame: view.frame)
        alert.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let messageWidth = message.width(font: UIFont.systemFont(ofSize: 17))
        let activityIndicatorContainerWidth = message.count != 0 ? messageWidth + 44 : 36
        let yPos = (alert.frame.height / 2) - 25
        let xPos = (alert.frame.width / 2) - (activityIndicatorContainerWidth / 2)
        let activityIndicatorContainerFrame = CGRect(origin: CGPoint(x: xPos, y: yPos), size: CGSize(width: activityIndicatorContainerWidth, height: 50))
        let loadingContainer = UIView(frame: activityIndicatorContainerFrame)
        loadingContainer.roundCorners(radius: 15)
        loadingContainer.backgroundColor = .white
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 8, y: 15, width: 20, height: 20))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        loadingIndicator.color = .black
        loadingContainer.addSubview(loadingIndicator)
        if message.count > 0 {
            let messageLabelFrame = CGRect(x: 36, y: 0, width: messageWidth, height: 50)
            let messageLabel = UILabel(frame: messageLabelFrame)
            messageLabel.text = message
            loadingContainer.addSubview(messageLabel)
        }
        alert.addSubview(loadingContainer)
        alert.restorationIdentifier = ActivityAssociatedKeys.activityKey
        let currentWindow = keyWindow()
        currentWindow.addSubview(alert)
    }
    
    func stopLoading(_ handler: (()->Void)? = nil) {
        let currentWindow = keyWindow()
        guard let alertView = currentWindow.subviews.first(where: {
            $0.restorationIdentifier == ActivityAssociatedKeys.activityKey
        }) else {
            handler?()
            return
        }
        alertView.removeFromSuperview()
        handler?()
    }
}

