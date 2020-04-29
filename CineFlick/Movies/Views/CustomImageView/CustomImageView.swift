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
        DispatchQueue.global(qos: .default).async {
            self.imageUrlString = url
            let nativeString = NSString(string: url)
            DispatchQueue.main.async {
                self.image = nil
            }
            if let cachedImage = self.imageCache.object(forKey: nativeString) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
            }
            do {
                guard let urlUrl = URL(string: url) else { return }
                let data = try Data(contentsOf: urlUrl)
                let imageToCache = UIImage(data: data)!
                if self.imageUrlString == url {
                    DispatchQueue.main.async {
                        self.image = imageToCache
                    }
                }
                self.imageCache.setObject(imageToCache, forKey: nativeString)
            } catch let error { print(error) }
        }
    }
    
}
