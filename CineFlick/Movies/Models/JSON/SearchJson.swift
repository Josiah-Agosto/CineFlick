//
//  SearchJson.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct SearchJson: Decodable {
    let page: Int
    let results: [results]
    let total_results: Int
    let total_pages: Int
    
    init(json: [String: Any]) {
        page = json["page"] as! Int
        results = json["results"] as! [results]
        total_results = json["total_results"] as! Int
        total_pages = json["total_pages"] as! Int
    }
}


struct results: Decodable {
    let poster_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int?]
    let id: Int?
    let original_title: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Double?
    let vote_count: Int?
    let video: Bool?
    let vote_average: Double?
    
    init(json: [String: Any]) {
        poster_path = json["poster_path"] as? String
        adult = json["adult"] as? Bool
        overview = json["overview"] as? String
        release_date = json["release_date"] as? String
        genre_ids = json["genre_ids"] as? [Int] ?? []
        id = json["id"] as? Int
        original_title = json["original_title"] as? String
        title = json["title"] as? String
        backdrop_path = json["backdrop_path"] as? String
        popularity = json["popularity"] as? Double
        vote_count = json["vote_count"] as? Int
        video = json["video"] as? Bool
        vote_average = json["vote_average"] as? Double
    }
}
