//
//  ImageEndpoint.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol ImageEndpointProtocol {
    var base: String { get }
    var path: String { get }
}


// Piecing URL
extension ImageEndpointProtocol {
    var secretKey: String {
        return Constants.apiKey
    }
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "\(secretKey)")
        ]
        return components
    }
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
