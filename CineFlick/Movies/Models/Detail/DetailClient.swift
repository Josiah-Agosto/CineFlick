//
//  DetailClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/26/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class DetailClient: DetailApi {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    func detailRequest(with id: String, completion: @escaping (Result<MovieDetail?, APIError>) -> Void) {
        let url: URL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constants.apiKey)&language=en-US")!
        getDetail(with: url, of: id, decode: { (json) -> MovieDetail? in
            guard let detail = json as? MovieDetail else { return nil }
            return detail
        }, completionHandler: completion)
    }
}
