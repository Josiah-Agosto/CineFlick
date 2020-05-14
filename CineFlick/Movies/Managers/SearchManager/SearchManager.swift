//
//  SearchManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class SearchManager {
    // References / Properties
    public var movieTitles: [String] = [] { didSet { updater?() } }
    public var movieImageUrls: [String] = [] { didSet { updater?() } }
    public var movieIds: [String] = [] { didSet { updater?() } }
    private var updater: (() -> ())? = nil
    private let session = URLSession(configuration: .default)
    private let configurationManager = ConfigurationManager.shared
    private let group = DispatchGroup()
    static let shared = SearchManager()
    
    public func searchForMoviesWith(query: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        configurationManager.fetchImages()
        searchRequest(from: query, with: completion)
    }

    
    private func searchRequest(from query: String?, with completion: @escaping(Result<Void, APIError>) -> Void) {
        let queriedUrl = "https://api.themoviedb.org/3/search/movie?api_key=\(Constants.apiKey)&language=\(Constants.selectedLanguage.rawValue)&\(replaceUrlWhitespaceFrom(query: query))&page=1&include_adult=false&region=\(Constants.selectedRegion.rawValue)"
        let request = URLRequest(url: URL(string: queriedUrl)!)
        group.enter()
        let task = session.dataTask(with: request) { (data, response, error) in
            defer { self.group.leave(); completion(.success(())); self.updater?() }
            if let error = error { NotificationController.displayError(message: error.localizedDescription) }
            guard let response = response as? HTTPURLResponse else { completion(.failure(.requestFailed)); completion(.failure(.requestFailed)); return }
            if response.statusCode == 200 {
                if let data = data {
                    do {
                        let searchModel = try! JSONDecoder().decode(SearchJson.self, from: data)
                        let results = searchModel.results
                        for itemInResult in results {
                            self.movieTitles.append(itemInResult.title ?? "N/A")
                        }
                        for imageUrl in results {
                            self.movieImageUrls.append("\(self.configurationManager.secureBaseUrl)\(self.configurationManager.imageSize)\(imageUrl.poster_path ?? "")")
                        }
                        for id in results {
                            guard let stringId = id.id else { return }
                            self.movieIds.append(String(stringId))
                        }
                    }
                }
            } else { completion(.failure(.requestFailed)) }
        }
        task.resume()
    }
    
    
    private func replaceUrlWhitespaceFrom(query from: String?) -> String {
        guard let nonNilString = from else { return "" }
        let urlStringWithWhitespacesRemoved = nonNilString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let returningString = "query=\(urlStringWithWhitespacesRemoved)"
        return returningString
    }

}
