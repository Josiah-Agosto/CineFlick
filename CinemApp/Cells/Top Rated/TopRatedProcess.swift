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
    let constant = apiKey
    // ImageProcess
    var titles: [String] = []
    var filmRatings: [String] = []
    var imageFilePaths: [String] = []
    // Api Request Requirements
    var filePath: [String] = []
    var secureImageUrl: String = ""
    var imageSize: String = ""
    var fullImageUrl: [String] = []
//    var movieImages: [UIImage] = []

    // Api Request
    func mainApiRequest(completionHandler: @escaping ([String]?, [String]?, [String]?, Error?) -> Void) -> Void {
        let group = DispatchGroup()
        // Titles
        let topRatedUrl: URL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=bf2ca98a5e17224c08b945e65322c940&language=en-US&page=1&region=US")!
        let session =  URLSession.shared
        let topRatedTitles = session.dataTask(with: topRatedUrl) {
            (data, response, error) in
            guard let data = data else { print("Error 7, \(error.debugDescription)"); return }
            do {
                let topRatedModel = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = topRatedModel.results else { print("Error 8, \(error.debugDescription)"); return }
                self.titles.removeAll()
                group.enter()
                for titles in results {
                    self.titles.append(titles.title)
                }
                group.leave()
                // Image File Paths
                let filePathSession = URLSession.shared
                let topRatedFilePaths = filePathSession.dataTask(with: topRatedUrl) {
                    (data, response, error) in
                    guard let data = data else { print("Error 9, \(error.debugDescription)"); return }
                    do {
                        let topRatedModel = try JSONDecoder().decode(MovieModel.self, from: data)
                        guard let results = topRatedModel.results else { print("Error 10, \(error.debugDescription)"); return }
                        self.filePath.removeAll()
                        group.enter()
                        for filePaths in results {
                            self.filePath.append(filePaths.poster_path ?? " ")
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
                                self.filmRatings.removeAll()
                                group.enter()
                                for filmRatings in results {
                                    self.filmRatings.append(String(filmRatings.vote_average))
                                }
                                group.leave()
                                group.notify(queue: DispatchQueue.main, execute: {
                                    completionHandler(self.titles, self.filmRatings, self.filePath, nil)
                                })
                            } catch let JSONError { completionHandler(nil, nil, nil, JSONError) }
                        }
                        topRatedFilmRatings.resume()
                    } catch let JSONError { completionHandler(nil, nil, nil, JSONError) }
                }
                topRatedFilePaths.resume()
            } catch let JSONError { completionHandler(nil, nil, nil, JSONError) }
        }
        topRatedTitles.resume()
    }
    // MARK: - Fix number 14
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
                self.filePath.removeAll()
                group.enter()
                for filePaths in results {
                    self.filePath.append(filePaths.poster_path ?? " ")
                }
                group.leave()
                group.notify(queue: DispatchQueue.main, execute: {
                    completionHandler(self.filePath, nil)
                })
            } catch let JSONError { completionHandler(nil, JSONError) }
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
                let imageProcessor = try JSONDecoder().decode(BaseImageModel.self, from: data)
                group.enter()
                self.secureImageUrl = imageProcessor.images.secure_base_url
                self.imageSize = imageProcessor.images.poster_sizes[4]
                for filePath in self.filePath {
                    self.fullImageUrl.append("\(self.secureImageUrl)\(self.imageSize)\(filePath)")
                }
                group.leave()
                group.notify(queue: DispatchQueue.main, execute: {
                    completionHandler(self.fullImageUrl, nil)
                })
            } catch let JSONError { completionHandler(nil, JSONError) }
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
            } catch let ImageError { completionHandler(nil, ImageError) }
        }
    }
    
} // Class End
