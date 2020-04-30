//
//  ConfigurationEnum.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

enum ConfigurationEnum {
    case Images
    case Countries
    case Languages
}



extension ConfigurationEnum: ConfigurationEndpointProtocol {
    var base: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var path: String {
        switch self {
        case .Images:
            return "configuration?api_key=\(Constants.apiKey)"
        case .Countries:
            return "configuration/countries?api_key=\(Constants.apiKey)"
        case .Languages:
            return "configuration/languages?api_key=\(Constants.apiKey)"
        }
    }
    
}
