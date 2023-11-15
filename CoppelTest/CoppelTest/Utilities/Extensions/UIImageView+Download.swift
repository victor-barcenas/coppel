//
//  UIImageView+Download.swift
//  CoppelTest
//
//  Created by Victor Alfonso Barcenas Monreal on 13/11/23.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func download(from url: String, placeHolder: UIImage? = nil) {
        var mutablePlaceholder = placeHolder
        if placeHolder == nil {
            mutablePlaceholder = UIImage.init(named: "placeholder")
        }
        image = mutablePlaceholder
        let imageServerUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: imageServerUrl) {
            if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
                DispatchQueue.main.async { [weak self] in
                    self?.image = imageFromCache
                }
                return
            } else {
                URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                    if error != nil {
                        print("UNABLE TO LOAD IMAGE FROM URL: \(String(describing: error?.localizedDescription))")
                        DispatchQueue.main.async { [weak self] in
                            self?.image = mutablePlaceholder
                        }
                        return
                    }
                    DispatchQueue.main.async { [weak self] in
                        if let data = data {
                            if let downloadedImage = UIImage(data: data) {
                                self?.image = downloadedImage
                                imageCache.setObject(downloadedImage,
                                                     forKey: url as AnyObject)
                            }
                        }
                    }
                }).resume()
            }
        }
    }
}
