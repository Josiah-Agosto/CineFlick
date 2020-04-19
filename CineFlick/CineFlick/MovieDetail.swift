//
//  Movie.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

// Movie
struct MovieDetail: Decodable {
    var page: Int
    var results: [Results]
    
    private enum MainCodingKeys: String, CodingKey {
        case page
        case results = "results"
    }
}

struct Results: Decodable {
    var voteCount: Int?
    var id: Int?
    var video: Bool?
    var voteAverage: Double?
    var title: String
    var popularity: Double?
    var posterPath: String?
    var originalLanguage: String?
    var genreIds: [Int]?
    var backdropPath: String?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var originalTitle: String?
    
    init(json: [String: Any]) {
        voteCount = json["vote_count"] as? Int ?? 0
        id = json["id"] as? Int ?? 0
        video = json["video"] as? Bool ?? false
        voteAverage = json["vote_average"] as? Double ?? 0
        title = json["title"] as? String ?? ""
        popularity = json["popularity"] as? Double ?? 0
        posterPath = json["poster_path"] as? String ?? ""
        originalLanguage = json["original_language"] as? String ?? ""
        genreIds = json["genre_ids"] as? [Int] ?? [0]
        backdropPath = json["backdrop_path"] as? String ?? ""
        adult = json["adult"] as? Bool ?? false
        overview = json["overview"] as? String ?? ""
        releaseDate = json["release_date"] as? String ?? ""
        originalTitle = json["original_title"] as? String ?? ""
    }
    
//    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIds = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview
//        case popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title
//        case video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
}
