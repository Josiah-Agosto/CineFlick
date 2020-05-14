//
//  DetailClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/26/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class DetailClient: IdClientProtocol {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func detailRequest(with id: String, completion: @escaping(Result<MovieDetailJson?, APIError>) -> Void) {
        let url: URL = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constants.apiKey)&language=\(Constants.selectedLanguage.rawValue)&append_to_response=videos")!
        fetchData(with: url, decode: { (json) -> MovieDetailJson? in
            guard let detailModel = json as? MovieDetailJson else { completion(.failure(.invalidData)); return nil }
            return detailModel
        }, completion: completion)
    }
}
