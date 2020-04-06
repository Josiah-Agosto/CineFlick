//
//  APIError.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:    
            return "Hmm, seems like the Request to server Failed"
        case .jsonConversionFailure:
            return "Hmm, seems like JSON conversion Failed"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful:
            return "Invalid Data"
        case .jsonParsingFailure:
            return "Hmm, seemed to be a JSON Parsing Failure"
        }
    }
}
