//
//  MovieImageModel.swift
//  CinemApp
//
//  Created by Josiah Agosto on 7/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

struct MovieImageModel: Decodable {
    let change_keys: [String]?
    let images: Images?
    
    init(json: [String: Any]) {
        change_keys = json["change_keys"] as? [String] ?? []
        images = json["images"] as? Images
    }
}

struct Images: Decodable {
    var base_url: String?
    var secure_base_url: String?
    var backdrop_sizes: [String]?
    var logo_sizes: [String]?
    var poster_sizes: [String]?
    var profile_sizes: [String]?
    var still_sizes: [String]?
    
    init(json: [String: Any]) {
        base_url = json["base_url"] as? String ?? "nil"
        secure_base_url = json["secure_base_url"] as? String ?? "nil"
        backdrop_sizes = json["backdrop_sizes"] as? [String] ?? []
        logo_sizes = json["logo_sizes"] as? [String] ?? []
        poster_sizes = json["poster_sizes"] as? [String] ?? []
        profile_sizes = json["profile_sizes"] as? [String] ?? []
        still_sizes = json["still_sizez"] as? [String] ?? []
    }
}
