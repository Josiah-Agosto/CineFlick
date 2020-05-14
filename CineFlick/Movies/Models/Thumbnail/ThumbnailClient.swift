//
//  ThumbnailClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/8/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

class ThumbnailClient: IdClientProtocol {
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func requestThumbnailUrl(with key: String, completion: @escaping(Result<YoutubeDataJson?, APIError>) -> Void) {
        let youtubeUrl: URL = URL(string: "https://www.googleapis.com/youtube/v3/videos?key=\(Constants.youtubeApiKey)&part=snippet&id=\(key)")!
        fetchData(with: youtubeUrl, decode: { (json) -> YoutubeDataJson? in
            guard let thumbnailModel = json as? YoutubeDataJson else { completion(.failure(.invalidData)); return nil }
            return thumbnailModel
        }, completion: completion)
    }
    
}
