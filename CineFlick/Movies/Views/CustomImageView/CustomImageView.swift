//
//  CustomImageView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class CustomImageView: UIImageView {
    private let imageCache = NSCache<NSString, UIImage>()
    private var imageUrlString: String?
    
    public func asynchronouslyLoadImage(with url: String) {
        self.imageUrlString = url
        let nativeString = NSString(string: url)
        guard let urlString = URL(string: url) else { return }
        DispatchQueue.main.async {
            self.image = UIImage(named: "ImageNotFound")
        }
        if let cachedImage = self.imageCache.object(forKey: nativeString) {
            self.image = cachedImage
        }
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil { print(error!.localizedDescription); return }
            guard let data = data else { print(error!.localizedDescription); return }
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data) else { DispatchQueue.main.async { self.image = UIImage(named: "ImageNotFound") }; return }
                if self.imageUrlString == url {
                    self.image = imageToCache
                }
                self.imageCache.setObject(imageToCache, forKey: nativeString)
            }
        }.resume()
    }
    
}
