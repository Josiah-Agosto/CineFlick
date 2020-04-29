//
//  MovieCastModel.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

struct MovieCastJson: Decodable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
    
    init(json: [String: Any]) {
        id = json["id"] as? Int
        cast = json["cast"] as? [Cast]
        crew = json["crew"] as? [Crew]
    }
}

struct Cast: Decodable {
    let cast_id: Int?
    let character: String?
    let credit_id: String?
    let gender: Int?
    let id: Int?
    let name: String?
    let order: Int?
    let profile_path: String?
    
    init(json: [String: Any]) {
        cast_id = json["cast_id"] as? Int
        character = json["character"] as? String
        credit_id = json["credit_id"] as? String
        gender = json["gender"] as? Int
        id = json["id"] as? Int
        name = json["name"] as? String
        order = json["order"] as? Int
        profile_path = json["profile_path"] as? String
    }
}

struct Crew: Decodable {
    let credit_id: String?
    let department: String?
    let gender: Int?
    let id: Int?
    let job: String?
    let name: String?
    let profile_path: String?
    
    init(json: [String: Any]) {
        credit_id = json["credit_id"] as? String
        department = json["department"] as? String
        gender = json["gender"] as? Int
        id = json["id"] as? Int
        job = json["job"] as? String
        name = json["name"] as? String
        profile_path = json["profile_path"] as? String
    }
}
