//
//  Movie.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

struct MovieModel: Decodable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Results]?
    
//    private enum MainCodingKeys: String, CodingKey {
//        case page
//        case total_results
//        case total_pages
//        case results = "results"
//    }

//    init(json: [String: Any]) {
//        page = json["page"] as? Int ?? 0
//        total_results = json["total_results"] as? Int ?? 0
//        total_pages = json["total_pages"] as? Int ?? 0
//        results = json["results"] as! [Results]
//    }
}

struct Results: Decodable {
    let vote_count: Int?
    let id: Int?
    let video: Bool?
    let vote_average: Float
    let title: String
    let popularity: Double?
    let poster_path: String?
    let original_language: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    let original_title: String?
    
    init(json: [String: Any]) {
        vote_count = json["vote_count"] as? Int ?? 0
        id = json["id"] as? Int ?? 0
        video = json["video"] as? Bool ?? false
        vote_average = json["vote_average"] as? Float ?? 0.0
        title = json["title"] as? String ?? ""
        popularity = json["popularity"] as? Double ?? 0
        poster_path = json["poster_path"] as? String ?? ""
        original_language = json["original_language"] as? String ?? ""
        genre_ids = json["genre_ids"] as? [Int] ?? [0]
        backdrop_path = json["backdrop_path"] as? String ?? ""
        adult = json["adult"] as? Bool ?? false
        overview = json["overview"] as? String ?? ""
        release_date = json["release_date"] as? String ?? ""
        original_title = json["original_title"] as? String ?? ""
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
