//
//  MovieEndpointProtocol.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol MovieEndpointProtocol {
    var base: String { get }
    var id: String { get set }
    var path: String { get }
}



extension MovieEndpointProtocol {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path + id
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "\(Constants.apiKey)"),
            URLQueryItem(name: "language", value: Constants.selectedLanguage.rawValue),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: Constants.selectedRegion.rawValue)
        ]
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
