//
//  ImageClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class ImageClient: APIClientProtocol {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func createImage(from imageConfig: ConfigurationEnum, completion: @escaping(Result<MovieImageJson?, APIError>) -> Void) {
        let endpoint = imageConfig
        let result = endpoint.request
        fetchData(with: result, decode: { (json) -> MovieImageJson? in
            guard let imageModel = json as? MovieImageJson else { completion(.failure(.invalidData)); return nil }
            return imageModel
        }, completion: completion)
    }
}
