//
//  CountryClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

class CountryClient: APIClientProtocol {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func countryClient(from imageConfig: ConfigurationEnum, completion: @escaping (Result<[CountryJson]?, APIError>) -> Void) {
        let endpoint = imageConfig
        let result = endpoint.request
        fetchData(with: result, decode: { (json) -> [CountryJson]? in
            guard let countryModel = json as? [CountryJson] else { completion(.failure(.invalidData)); return [] }
            return countryModel
        }, completion: completion)
    }
}
