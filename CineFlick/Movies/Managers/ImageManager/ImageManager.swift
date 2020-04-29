//
//  ImageManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/28/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class ImageManager {
    // References /  Properties
    private let group = DispatchGroup()
    private lazy var imageClient = ImageClient()
    public var secureBaseUrl: String = ""
    public var imageSize: String = ""
    public var backdropSize: String = ""
    
    // MARK: - Generate Image
    public func generateImages() {
        group.enter()
        imageClient.createImage(from: .configure) { (result) in
            switch result {
            case .success(let imageFeedResult):
                defer { self.group.leave() }
                guard let imageCreation = imageFeedResult?.images else { return }
                guard let secure = imageCreation.secure_base_url else { return }
                guard let posterSize = imageCreation.poster_sizes?[4] else { return }
                guard let backdropSize = imageCreation.backdrop_sizes?[2] else { return }
                self.secureBaseUrl = secure
                self.imageSize = posterSize
                self.backdropSize = backdropSize
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
