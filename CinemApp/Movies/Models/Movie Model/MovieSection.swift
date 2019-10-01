//
//  MovieSection.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum MovieSection {
    case popular
    case nowPlaying
    case upcoming
    case topRated
}

// Creates the url with above cases
extension MovieSection: Endpoint {
    var base: String {
        return "https://api.themoviedb.org"
    }
    // Chooses which request to get
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
        }
    }
}
