//
//  NowPlayingMovieModel.swift
//  CinemApp
//
//  Created by Josiah Agosto on 7/25/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

struct MovieModelWithDates: Decodable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [Results]?
    let dates: Dates?
//
//    private enum MainCodingKeys: String, CodingKey {
//        case page
//        case total_results
//        case total_pages
//        case results = "results"
//        case dates = "dates"
//    }
//    init(json: [String: Any]) {
//        page = json["page"] as? Int ?? 0
//        total_results = json["total_results"] as? Int ?? 0
//        total_pages = json["total_pages"] as? Int ?? 0
//        results = json["results"] as? [Results]
//        dates = json["dates"] as! Dates
//    }
    
    // Result Array
    struct Results: Decodable {
        let vote_count: Int
        let id: Int
        let video: Bool
        let vote_average: Float
        let title: String
        let popularity: Float
        let poster_path: String?
        let original_language: String
        let original_title: String
        let genre_ids: [Int]?
        let backdrop_path: String?
        let adult: Bool
        let overview: String
        let release_date: String
        
        init(json: [String: Any]) {
            vote_count = json["vote_count"] as! Int
            id = json["id"] as! Int
            video = json["video"] as! Bool
            vote_average = json["vote_average"] as! Float
            title = json["title"] as! String
            popularity = json["popularity"] as! Float
            poster_path = json["poster_path"] as? String
            original_language = json["original_language"] as! String
            original_title = json["original_title"] as! String
            genre_ids = json["genre_ids"] as? [Int]
            backdrop_path = json["backdrop_path"] as? String
            adult = json["adult"] as! Bool
            overview = json["overview"] as! String
            release_date = json["release_data"] as! String
        }
    }
    // Data Object
    struct Dates: Decodable {
        let minimum: String
        let maximum: String
        
        init(json: [String: Any]) {
            minimum = json["minimum"] as! String
            maximum = json["maximum"] as! String
        }
    }
}
