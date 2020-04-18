//
//  CastClient.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class CastClient: CastApi {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func castRequest(with id: String, completion: @escaping (Result<MovieCastModel?, APIError>) -> Void) {
        let url: URL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(apiKey)")!
        getCast(with: url, of: id, decode: { (json) -> MovieCastModel? in
            guard let cast = json as? MovieCastModel else { return nil }
            return cast
        }, completionHandler: completion)
    }
}
