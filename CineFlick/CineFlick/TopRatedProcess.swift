//
//  TopRatedProcess.swift
//  CinemApp
//
//  Created by Josiah Agosto on 7/28/19.
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
    var movieImages: [UIImage] = []
    
    // Api Request
    func mainApiRequest(completionHandler: @escaping ([String]?, [String]?, [String]?, Error?) -> Void) -> Void {
        // Title
        let group1 = DispatchGroup()
        // Film Ratings
        let group2 = DispatchGroup()
        // File Paths
        let group3 = DispatchGroup()
        // Titles
        let topRatedUrl: URL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(constant)&language=en-US&page=1")!
        let session =  URLSession.shared
        let topRatedTitles = session.dataTask(with: topRatedUrl) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let topRatedModel = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = topRatedModel.results else { return }
                self.titles.removeAll()
                group1.enter()
                for titles in results {
                    self.titles.append(titles.title)
                }
                group1.leave()
                completionHandler(self.titles, nil, nil, nil)
            } catch let JSONError { completionHandler(nil, nil, nil, JSONError) }
        }
        topRatedTitles.resume()
        // Film Ratings
        let filmRatingSession = URLSession.shared
        let topRatedFilmRatings = filmRatingSession.dataTask(with: topRatedUrl) {
            (data, reesponse, error) in
            guard let data = data else { return }
            do {
                let topRatedModel = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = topRatedModel.results else { return }
                self.filmRatings.removeAll()
                group2.enter()
                for filmRatings in results {
                    self.filmRatings.append(String(filmRatings.vote_average))
                }
                group2.leave()
                completionHandler(nil, self.filmRatings, nil, nil)
            } catch let JSONError { completionHandler(nil, nil, nil, JSONError) }
        }
        topRatedFilmRatings.resume()
        // Image File Paths
        let filePathSession = URLSession.shared
        let topRatedFilePaths = filePathSession.dataTask(with: topRatedUrl) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let topRatedModel = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = topRatedModel.results else { return }
                self.filePath.removeAll()
                group3.enter()
                for filePaths in results {
                    self.filePath.append(filePaths.poster_path ?? " ")
                }
                group3.leave()
                completionHandler(nil, nil, self.filePath, nil)
            } catch let JSONError { completionHandler(nil, nil, nil, JSONError) }
        }
        topRatedFilePaths.resume()
    }
    
    // Image Processors
    func filePathRequest(completionHandler: @escaping ([String]?, Error?) -> Void) -> Void {
        let group = DispatchGroup()
        let nowPlayingUrl: URL = URL(string: "https://api.themoviedb.org/3/configuration?api_key=\(constant)")!
        let session = URLSession.shared
        let imageDataTask = session.dataTask(with: nowPlayingUrl) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let nowPlayingModel = try JSONDecoder().decode(MovieModelWithDates.self, from: data)
                guard let results = nowPlayingModel.results else { return }
                self.filePath.removeAll()
                group.enter()
                for filePaths in results {
                    self.filePath.append(filePaths.poster_path ?? " ")
                }
                group.leave()
                completionHandler(self.filePath, nil)
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
            guard let data = data else { return }
            do {
                let imageProcessor = try JSONDecoder().decode(BaseImageModel.self, from: data)
                group.enter()
                self.secureImageUrl = imageProcessor.images.secure_base_url
                self.imageSize = imageProcessor.images.poster_sizes[4]
                for filePath in self.filePath {
                    self.fullImageUrl.append("\(self.secureImageUrl)\(self.imageSize)\(filePath)")
                }
                group.leave()
                completionHandler(self.fullImageUrl, nil)
            } catch let JSONError { completionHandler(nil, JSONError) }
        }
        imageDataTask.resume()
    }
    
    
    func makeUrlAnImage(completionHandler: @escaping ([UIImage]?, Error?) -> Void) -> Void {
        let group = DispatchGroup()
        for imageURL in self.fullImageUrl {
            let url = URL(string: imageURL)!
            do {
                let data = try Data(contentsOf: url)
                group.enter()
                let image: UIImage = UIImage(data: data)!
                self.movieImages.append(image)
                group.leave()
                completionHandler(self.movieImages, nil)
            } catch let ImageError { completionHandler(nil, ImageError) }
        }
    }

} // Class End
