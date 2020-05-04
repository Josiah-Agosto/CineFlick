//
//  LanguageClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

class LanguageClient: APIClientProtocol {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func languageClient(from imageConfig: ConfigurationEnum, completion: @escaping(Result<[LanguageJson]?, APIError>) -> Void) {
        let endpoint = imageConfig
        let result = endpoint.request
        fetchData(with: result, decode: { (json) -> [LanguageJson]? in
            guard let languageModel = json as? [LanguageJson] else { completion(.failure(.invalidData)); return [] }
            return languageModel
        }, completion: completion)
    }
}
