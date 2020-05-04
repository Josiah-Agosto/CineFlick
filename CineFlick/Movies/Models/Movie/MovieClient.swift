//
//  MovieClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class MovieClient: APIClientProtocol {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func getFeed(from movieSectionType: MovieEnum, completion: @escaping(Result<MovieDatesJson?, APIError>) -> Void) {
        let endpoint = movieSectionType
        let result = endpoint.request
        fetchData(with: result, decode: { (json) -> MovieDatesJson? in
            guard let movieModel = json as? MovieDatesJson else { completion(.failure(.invalidData)); return nil }
            return movieModel
        }, completion: completion)
    }
}
