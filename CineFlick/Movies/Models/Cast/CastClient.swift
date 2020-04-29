//
//  CastClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class CastClient: CastApiProtocol {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func castRequest(with id: String, completion: @escaping (Result<MovieCastJson?, APIError>) -> Void) {
        let url: URL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(Constants.apiKey)")!
        getCast(with: url, of: id, decode: { (json) -> MovieCastJson? in
            guard let cast = json as? MovieCastJson else { return nil }
            return cast
        }, completionHandler: completion)
    }
}
