//
//  MovieImageModel.swift
//  CinemApp
//
//  Created by Josiah Agosto on 7/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

struct BaseImageModel: Decodable {
    let change_keys: [String]
    let images: Images
    
//    private enum CodingKeys: String, CodingKey {
//        case change_keys
//        case images
//    }
//
//    init(json: [String: Any]) {
//        change_keys = json["change_keys"] as! ChangeKeys
//        images = json["images"] as! Images
//    }
    
    struct Images: Decodable {
        var base_url: String
        var secure_base_url: String
        var backdrop_sizes: [String]
        var logo_sizes: [String]
        var poster_sizes: [String]
        var profile_sizes: [String]
        var still_sizes: [String]
        
        private enum CodingKeys: String, CodingKey {
            case base_url = "base_url"
            case secure_base_url = "secure_base_url"
            case backdrop_sizes = "backdrop_sizes"
            case logo_sizes = "logo_sizes"
            case poster_sizes = "poster_sizes"
            case profile_sizes = "profile_sizes"
            case still_sizes = "still_sizes"
        }
    }
}
