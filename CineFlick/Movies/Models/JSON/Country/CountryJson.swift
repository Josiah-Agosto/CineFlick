//
//  CountryJson.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct CountryJson: Decodable {
    let iso_3166_1: String
    let english_name: String
    
    init(json: [String: Any]) {
        iso_3166_1 = json["iso_3166_1"] as! String
        english_name = json["english_name"] as! String
    }
}
