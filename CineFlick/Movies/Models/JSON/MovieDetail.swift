//
//  MovieDetail.swift
//  CineFlicks
//
//  Created by Josiah Agosto on 9/21/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

struct MovieDetail: Decodable {
    let adult: Bool?
    let backdrop_path: String?
    let belongs_to_collection: object?
    let budget: Int?
    let genres: [Genres]?
    let homepage: String?
    let id: Int?
    let imdb_id: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let production_companies: [Production_companies]?
    let production_countries: [Production_countries]?
    let release_date: String?
    let revenue: Int?
    let runtime: Int?
    let spoken_languages: [Spoken_languages]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    
    init(json: [String: Any]) {
        adult = json["adult"] as? Bool
        backdrop_path = json["backdrop_path"] as? String
        belongs_to_collection = json["belongs_to_collection"] as? object
        budget = json["budget"] as? Int
        genres = json["genres"] as? [Genres]
        homepage = json["homepage"] as? String
        id = json["id"] as? Int
        imdb_id = json["imdb_id"] as? String
        original_language = json["original_language"] as? String
        original_title = json["original_title"] as? String
        overview = json["overview"] as? String
        popularity = json["popularity"] as? Double
        poster_path = json["poster_path"] as? String
        production_companies = json["production_companies"] as? [Production_companies]
        production_countries = json["production_countries"] as? [Production_countries]
        release_date = json["release_date"] as? String
        revenue = json["revenue"] as? Int
        runtime = json["runtime"] as? Int
        spoken_languages = json["spoken_languages"] as? [Spoken_languages]
        status = json["status"] as? String
        tagline = json["tagline"] as? String
        title = json["title"] as? String
        video = json["video"] as? Bool
        vote_average = json["vote_average"] as? Double
        vote_count = json["vote_count"] as? Int
    }
}

struct Production_companies: Decodable {
    let name: String?
    let id: Int?
    let logo_path: String?
    let origin_country: String?

    init(json: [String: Any]) {
        name = json["name"] as? String
        id = json["id"] as? Int
        logo_path = json["String"] as? String
        origin_country = json["origin_country"] as? String
    }
}

struct Production_countries: Decodable {
    let iso_3166_1: String?
    let name: String?
    
    init(json: [String: Any]) {
        iso_3166_1 = json["iso_3166_1"] as? String
        name = json["name"] as? String
    }
}

struct Spoken_languages: Decodable {
    let iso_639_1: String?
    let name: String?
    
    init(json: [String: Any]) {
        iso_639_1 = json["iso_639_1"] as? String
        name = json["name"] as? String
    }
}

struct Genres: Decodable {
    let id: Int?
    let name: String?
    
    init(json: [String: Any]) {
        id = json["id"] as? Int
        name = json["name"] as? String
    }
}

struct object: Codable {
}
