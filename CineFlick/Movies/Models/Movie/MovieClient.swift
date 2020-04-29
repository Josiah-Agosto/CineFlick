//
//  MovieClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class MovieClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func getFeed(from movieSectionType: MovieSection, completion: @escaping (Result<MovieDatesJson?, APIError>) -> Void) {
        let endpoint = movieSectionType
        let result = endpoint.request
        fetch(with: result, decode: { (json) -> MovieDatesJson? in
            guard let movieModel = json as? MovieDatesJson else { print("Error here!"); return nil }
            return movieModel
        }, completion: completion)
    }
}
