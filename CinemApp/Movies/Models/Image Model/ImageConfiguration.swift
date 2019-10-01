//
//  ImageConfiguration.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum ImageConfiguaration {
    case configure
}


// Creates url For Image
extension ImageConfiguaration: ImageEndpoint {
    var base: String {
        return "https://api.themoviedb.org"
    }
    // Path needed for Configuring Image URL's
    var path: String {
        return "/3/configuration"
    }
}
