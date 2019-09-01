//
//  PopularProcess.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class PopularProcess: ImageProcessorRequirements, ApiRequestRequirements {
    // Constant
    let constant: String = apiKey
    // Temporary Data Holders from JSON
    var titles: [String] = []
    var filmRatings: [String] = []
    var imageFilePaths: [String] = []
    // Image Processor Protocol Stubs
    var filePath: [String] = []
    var secureImageUrl: String = ""
    var imageSize: String = ""
    var fullImageUrl: [String] = []
    var movieImages: [UIImage] = []
    
    // Movie Request
    func mainApiRequest(completionHandler: @escaping ([String]?, [String]?, [String]?, Error?) -> Void) {
        let group1 = DispatchGroup()
        let group2 = DispatchGroup()
        let group3 = DispatchGroup()
        //MARK: - Insert API Key Here
        // Insert YOUR API KEY here, Remove Underscore and enter a title.
        let _: String = ""
        // Data Request
        let popularMovieDataURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(constant)&language=en-US&page=1")!
        // Session for getting Title
        let session = URLSession.shared
        let dataTask = session.dataTask(with: popularMovieDataURL) {
            (data, response, error) in
            guard let data = data else { print("Error recieving URL!"); return }
            do {
                let popularMovies = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = popularMovies.results else { return }
                group1.enter()
                self.titles.removeAll()
                for titles in results {
                    self.titles.append(titles.title)
                }
                group1.leave()
                completionHandler(self.titles, nil, nil, nil)
            } catch let JSONError { completionHandler(nil, nil, nil, JSONError); print(JSONError) }
        }
        dataTask.resume()
        // Session for getting Film Rating
        let sessionFilmRating = URLSession.shared
        let dataTaskFilmRating = sessionFilmRating.dataTask(with: popularMovieDataURL) {
            (data, response, error) in
            guard let data = data else { print("Error recieving Film Rating URL!"); return }
            do {
                let popularMovies = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = popularMovies.results else { return }
                group2.enter()
                self.filmRatings.removeAll()
                for filmRating in results {
                    self.filmRatings.append(String(filmRating.vote_average))
                }
                group2.leave()
                completionHandler(nil, self.filmRatings, nil, nil)
            } catch let JSONError { completionHandler(nil, nil, nil, JSONError); print(JSONError) }
        }
        dataTaskFilmRating.resume()
        // Movie Image Request
        let sessionMovieImage = URLSession.shared
        let dataTaskMovieImage = sessionMovieImage.dataTask(with: popularMovieDataURL) {
            (data, response, error) in
            guard let data = data else { print("Error recieving Movie Image URL"); return }
            do {
                let popularMovies = try JSONDecoder().decode(MovieModel.self, from: data)
                guard let results = popularMovies.results else { return }
                group3.enter()
                self.imageFilePaths.removeAll()
                for movieImages in results {
                    self.imageFilePaths.append(movieImages.poster_path ?? "Error")
                }
                group3.leave()
                completionHandler(nil, nil, self.imageFilePaths, nil)
            } catch let JSONError { completionHandler(nil, nil, nil, JSONError); print(JSONError) }
        }
        dataTaskMovieImage.resume()
    }
    
    
    func filePathRequest(completionHandler: @escaping ([String]?, Error?) -> Void) {
        let group = DispatchGroup()
        let nowPlayingUrl: URL = URL(string: "https://api.themoviedb.org/3/configuration?api_key=\(constant)")!
        let session = URLSession.shared
        let imageDataTask = session.dataTask(with: nowPlayingUrl) {
            (data, response, error) in
            guard let data = data else { return }
            do {
                let nowPlayingModel = try JSONDecoder().decode(MovieModelWithDates.self, from: data)
                guard let results = nowPlayingModel.results else { return }
                group.enter()
                self.filePath.removeAll()
                for filePaths in results {
                    self.filePath.append(filePaths.poster_path ?? "Error")
                }
                group.leave()
                completionHandler(self.filePath, nil)
            } catch let JSONError { completionHandler(nil, JSONError); print(JSONError) }
        }
        imageDataTask.resume()
    }
    
    
    func convertToUrl(completionHandler: @escaping ([String]?, Error?) -> Void) {
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
            } catch let JSONError { completionHandler(nil, JSONError); print(JSONError) }
        }
        imageDataTask.resume()
    }
    
    
    func makeUrlAnImage(completionHandler: @escaping ([UIImage]?, Error?) -> Void) {
        let group = DispatchGroup()
        for imageURL in self.fullImageUrl {
            let url = URL(string: imageURL)!
            do {
                group.enter()
                let data = try Data(contentsOf: url)
                let image: UIImage = UIImage(data: data)!
                self.movieImages.append(image)
                group.leave()
                completionHandler(self.movieImages, nil)
            } catch let ImageError { completionHandler(nil, ImageError); print(ImageError) }
        }
    }
    
    
} // Class End
