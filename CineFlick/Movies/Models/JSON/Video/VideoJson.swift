//
//  VideoJson.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/5/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct VideoJson: Decodable {
    let results: [VideoResults]
    
    init(json: [String: Any]) {
        results = json["results"] as! [VideoResults]
    }
}


struct VideoResults: Decodable {
    let id: String
    let iso_639_1: String
    let iso_3166_1: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: String
    
    init(json: [String: Any]) {
        id = json["id"] as! String
        iso_639_1 = json["iso_639_1"] as! String
        iso_3166_1 = json["iso_3166_1"] as! String
        key = json["key"] as! String
        name = json["name"] as! String
        site = json["site"] as! String
        size = json["size"] as! Int
        type = json["type"] as! String
    }
}
