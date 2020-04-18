//
//  ImageConfiguration.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum ImageConfiguration {
    case configure
}


// Piecing URL
extension ImageConfiguration: ImageEndpoint {
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        return "/3/configuration"
    }
}
