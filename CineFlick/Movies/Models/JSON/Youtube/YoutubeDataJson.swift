//
//  YoutubeDataJson.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/8/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct YoutubeDataJson: Decodable {
    let kind: String
    let etag: String
    let items: [Items]
    let pageInfo: PageInfo
    
    init(json: [String: Any]) {
        kind = json["kind"] as! String
        etag = json["etag"] as! String
        items = json["items"] as! [Items]
        pageInfo = json["pageInfo"] as! PageInfo
    }
}


struct Items: Decodable {
    let kind: String
    let etag: String
    let id: String
    let snippet: Snippet
    
    init(json: [String: Any]) {
        kind = json["kind"] as! String
        etag = json["etag"] as! String
        id = json["id"] as! String
        snippet = json["snippet"] as! Snippet
    }
}


struct PageInfo: Decodable {
    let totalResults: Int
    let resultsPerPage: Int
    
    init(json: [String: Any]) {
        totalResults = json["totalResults"] as! Int
        resultsPerPage = json["resultsPerPage"] as! Int
    }
}


struct Snippet: Decodable {
    let publishedAt: String
    let channelId: String
    let title: String
    let description: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let tags: [String]
    let categoryId: String
    let liveBroadcastContent: String
    let localized: Localized
    let defaultAudioLanguage: String
    
    init(json: [String: Any]) {
        publishedAt = json["publishedAt"] as! String
        channelId = json["channelId"] as! String
        title = json["title"] as! String
        description = json["description"] as! String
        thumbnails = json["thumbnails"] as! Thumbnails
        channelTitle = json["channelTitle"] as! String
        tags = json["tags"] as! [String]
        categoryId = json["categoryId"] as! String
        liveBroadcastContent = json["liveBroadcastContent"] as! String
        localized = json["localized"] as! Localized
        defaultAudioLanguage = json["defaultAudioLanguage"] as! String
    }
}


struct Localized: Decodable {
    let title: String
    let description: String
    
    init(json: [String: Any]) {
        title = json["title"] as! String
        description = json["description"] as! String
    }
}


struct Thumbnails: Decodable {
    let `default`: Default
    let medium: Medium
    let high: High
    let standard: Standard
    let maxres: MaxRes
    
    init(json: [String: Any]) {
        `default` = json["default"] as! Default
        medium = json["medium"] as! Medium
        high = json["high"] as! High
        standard = json["standard"] as! Standard
        maxres = json["maxres"] as! MaxRes
    }
}


struct Default: Decodable {
    let url: String
    let width: Int
    let height: Int
    
    init(json: [String: Any]) {
        url = json["url"] as! String
        width = json["width"] as! Int
        height = json["height"] as! Int
    }
}


struct Medium: Decodable {
    let url: String
    let width: Int
    let height: Int
    
    init(json: [String: Any]) {
        url = json["url"] as! String
        width = json["width"] as! Int
        height = json["height"] as! Int
    }
}


struct High: Decodable {
    let url: String
    let width: Int
    let height: Int
    
    init(json: [String: Any]) {
        url = json["url"] as! String
        width = json["width"] as! Int
        height = json["height"] as! Int
    }
}


struct Standard: Decodable {
    let url: String
    let width: Int
    let height: Int
    
    init(json: [String: Any]) {
        url = json["url"] as! String
        width = json["width"] as! Int
        height = json["height"] as! Int
    }
}


struct MaxRes: Decodable {
    let url: String
    let width: Int
    let height: Int
    
    init(json: [String: Any]) {
        url = json["url"] as! String
        width = json["width"] as! Int
        height = json["height"] as! Int
    }
}
