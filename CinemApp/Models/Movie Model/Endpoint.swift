//
//  Endpoint.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
// Used to make a URL Request. URL composes of: Base, Path to what you want, then the api key to access that path.
protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

// Creates the URL
extension Endpoint {
    var secretKey: String {
        return apiKey
    }
    var extraQuery: String {
        return "&language=en-US&page=1&region=US"
    }
    // What makes the URL
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = secretKey + extraQuery
        return components
    }
    // Creating the Request with the URL above
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
