//
//  MovieEnum.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum MovieEnum {
    case popular
    case nowPlaying
    case upcoming
    case topRated
    case detail
    case credits
}



extension MovieEnum: MovieEndpointProtocol {
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var id: String {
        get {
            return ""
        }
        set {
            print(newValue)
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .upcoming:
            return "/3/movie/upcoming"
        case .topRated:
            return "/3/movie/top_rated"
        case .detail:
            return "/3/movie/\(id)"
        case .credits:
            return "/3/movie/\(id)"
        }
    }
    
}
