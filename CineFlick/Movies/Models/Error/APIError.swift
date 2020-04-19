//
//  APIError.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidData
    case noInternetConnection
    case serverTimedOut
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:    
            return "Hmm, seems like the request to server Failed. Please check your connection and Try Again."
        case .invalidData:
            return "Server data incorrect. Please check back later and Try Again."
        case .noInternetConnection:
            return "Uh Oh, no Internet Connection. Connect to the Internet and Try again."
        case .serverTimedOut:
            return "The request to server has Timed Out. Try again later."
        }
    }
}
