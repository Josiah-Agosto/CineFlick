//
//  LanguageJson.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct LanguageJson: Decodable {
    let iso_639_1: String
    let english_name: String
    let name: String
    
    init(json: [String: Any]) {
        iso_639_1 =  json["iso_639_1"] as! String
        english_name = json["english_name"] as! String
        name = json["name"] as! String
    }
}
