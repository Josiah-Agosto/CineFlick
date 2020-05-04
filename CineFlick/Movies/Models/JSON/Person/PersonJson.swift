//
//  PersonJson.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/3/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct PersonJson: Decodable {
    let birthday: String?
    let known_for_department: String
    let deathday: String?
    let id: Int
    let name: String
    let also_known_as: [String]
    let gender: Int
    let biography: String
    let popularity: Double
    let place_of_birth: String?
    let profile_path: String?
    let adult: Bool
    let imdb_id: String
    let homepage: String?
    
    init(json: [String: Any]) {
        birthday = json["birthday"] as? String
        known_for_department = json["known_for_department"] as! String
        deathday = json["deathday"] as? String
        id = json["id"] as! Int
        name = json["name"] as! String
        also_known_as = json["also_known_as"] as! [String]
        gender = json["gender"] as! Int
        biography = json["biography"] as! String
        popularity = json["popularity"] as! Double
        place_of_birth = json["place_of_birth"] as? String
        profile_path = json["profile_path"] as? String
        adult = json["adult"] as! Bool
        imdb_id = json["imdb_id"] as! String
        homepage = json["homepage"] as? String
    }
}
