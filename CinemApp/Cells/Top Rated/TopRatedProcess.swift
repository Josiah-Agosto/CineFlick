//
//  TopRatedProcess.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class TopRatedProcess: ApiRequestRequirements, ImageProcessorRequirements {
    // Constant
    private let constant = apiKey
    // ImageProcess
    internal var titles: [String] = []
    internal var filmRatings: [String] = []
    internal var imageFilePaths: [String] = []
    // Api Request Requirements
    internal var filePath: [String] = []
    internal var secureImageUrl: String = ""
    internal var imageSize: String = ""
    internal var fullImageUrl: [String] = []

    // Api Request
    func mainApiRequest(completionHandler: @escaping ([String]?, [String]?, Error?) -> Void) -> Void {
        let group = DispatchGroup()
        // Titles
        let topRatedUrl: URL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(constant)&language=en-US&page=1&region=US")!
        let session =  URLSession.shared
        let topRatedTitles = session.dataTask(with: topRatedUrl) {
            (data, response, error) in
            guard let data = data else { print("Error 7, \(error.debugDescription)"); return }
            do {
                let topRatedModel = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = topRatedModel.results else { print("Error 8, \(error.debugDescription)"); return }
                group.enter()
                self.titles.removeAll()
                for titles in results {
                    self.titles.append(titles.title)
                }
                group.leave()
                        // Film Ratings
                        let filmRatingSession = URLSession.shared
                        let topRatedFilmRatings = filmRatingSession.dataTask(with: topRatedUrl) {
                            (data, reesponse, error) in
                            guard let data = data else { print("Error 11, \(error.debugDescription)"); return }
                            do {
                                let topRatedModel = try JSONDecoder().decode(MovieModel.self, from: data)
                                guard let results = topRatedModel.results else { print("Error 12, \(error.debugDescription)"); return }
                                group.enter()
                                self.filmRatings.removeAll()
                                for filmRatings in results {
                                    self.filmRatings.append(String(filmRatings.vote_average))
                                }
                                group.leave()
                                group.notify(queue: DispatchQueue.main, execute: {
                                    completionHandler(self.titles, self.filmRatings, nil)
                                })
                            } catch let JSONError { completionHandler(nil, nil, JSONError); print(JSONError) }
                        }
                        topRatedFilmRatings.resume()
            } catch let JSONError { completionHandler(nil, nil, JSONError); print(JSONError) }
        }
        topRatedTitles.resume()
    }

    // Image Processors
    func filePathRequest(completionHandler: @escaping ([String]?, Error?) -> Void) -> Void {
        let group = DispatchGroup()
        let nowPlayingUrl: URL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(constant)&language=en-US&page=1")!
        let session = URLSession.shared
        let imageDataTask = session.dataTask(with: nowPlayingUrl) {
            (data, response, error) in
            guard let data = data else { print("Error 13, \(error.debugDescription)"); return }
            do {
                let nowPlayingModel = try JSONDecoder().decode(MovieModelWithDates.self, from: data)
                guard let results = nowPlayingModel.results else { print("Error 14, \(error.debugDescription)"); return }
                group.enter()
                self.filePath.removeAll()
                for filePaths in results {
                    self.filePath.append(filePaths.poster_path ?? " ")
                }
                print("Top Rated: \(self.filePath)")
                group.leave()
                group.notify(queue: DispatchQueue.main, execute: {
                    completionHandler(self.filePath, nil)
                })
            } catch let JSONError { completionHandler(nil, JSONError); print(JSONError) }
        }
        imageDataTask.resume()
    }
    
    
    func convertToUrl(completionHandler: @escaping ([String]?, Error?) -> Void) -> Void {
        let group = DispatchGroup()
        let securedBaseUrl: URL = URL(string: "https://api.themoviedb.org/3/configuration?api_key=\(constant)")!
        let session = URLSession.shared
        let imageDataTask = session.dataTask(with: securedBaseUrl) {
            (data, response, error) in
            guard let data = data else { print("Error 15, \(error.debugDescription)"); return }
            do {
                group.enter()
                let imageProcessor = try JSONDecoder().decode(BaseImageModel.self, from: data)
                self.secureImageUrl = imageProcessor.images.secure_base_url
                self.imageSize = imageProcessor.images.poster_sizes[4]
                for filePath in self.filePath {
                    self.fullImageUrl.append("\(self.secureImageUrl)\(self.imageSize)\(filePath)")
                }
                print("Top Rated: \(self.fullImageUrl)")
                group.leave()
                group.notify(queue: DispatchQueue.main, execute: {
                    completionHandler(self.fullImageUrl, nil)
                })
            } catch let JSONError { completionHandler(nil, JSONError); print(JSONError) }
        }
        imageDataTask.resume()
    }
    
    
    func makeUrlAnImage(completionHandler: @escaping ([UIImage]?, Error?) -> Void) -> Void {
        var movieImages: [UIImage] = []
        for imageURL in self.fullImageUrl {
            let url = URL(string: imageURL)!
            do {
                let data = try Data(contentsOf: url)
                let image: UIImage = UIImage(data: data)!
                movieImages.append(image)
                completionHandler(movieImages, nil)
            } catch let ImageError { completionHandler(nil, ImageError); print(ImageError) }
        }
    }
    
} // Class End
