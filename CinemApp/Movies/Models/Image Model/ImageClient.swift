//
//  ImageClient.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class ImageClient: ImageAPIClient {
    let session: URLSession
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    func createImage(from imageConfig: ImageConfiguaration, completion: @escaping (Result<MovieImageModel?, APIError>) -> Void) {
        let endpoint = imageConfig
        let result = endpoint.request
        fetchImage(with: result, decode: { (json) -> MovieImageModel? in
            guard let imageModel = json as? MovieImageModel else { print("Image Error here!"); return nil }
            return imageModel
        }, completion: completion)
    }
}
