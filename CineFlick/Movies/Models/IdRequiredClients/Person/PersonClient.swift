//
//  PersonClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/3/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

class PersonClient: IdClientProtocol {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getPersonInfo(with id: String, completion: @escaping(Result<PersonJson?, APIError>) -> Void) {
        let url: URL = URL(string: "https://api.themoviedb.org/3/person/\(id)?api_key=\(Constants.apiKey)&language=\(Constants.selectedLanguage.rawValue)")!
        fetchData(with: url, decode: { (json) -> PersonJson? in
            guard let personModel = json as? PersonJson else { completion(.failure(.invalidData)); return nil }
            return personModel
        }, completion: completion)
    }
}
