//
//  CastClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class CastClient: IdClientProtocol {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func castRequest(with id: String, completion: @escaping(Result<MovieCastJson?, APIError>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(Constants.apiKey)")!
        fetchData(with: url, decode: { (json) -> MovieCastJson? in
            guard let castModel = json as? MovieCastJson else { completion(.failure(.invalidData)); return nil }
            return castModel
        }, completion: completion)
    }
}
