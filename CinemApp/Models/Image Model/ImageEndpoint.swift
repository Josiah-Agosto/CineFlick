//
//  ImageEndpoint.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
// Used to make a URL Request. URL composes of: Base, Path to what you want, then the api key to access that path.
protocol ImageEndpoint {
    var base: String { get }
    var path: String { get }
}


// Extension to set the Endpoint
extension ImageEndpoint {
    var secretKey: String {
        return apiKey
    }
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.query = secretKey
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
