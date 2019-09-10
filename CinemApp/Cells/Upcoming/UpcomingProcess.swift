//
//  UpcomingProcess.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class UpcomingProcess: ImageProcessorRequirements, ApiRequestWithDatesRequirements {
    // Constant
    let constant = apiKey
    // Temporary Data Holders from JSON
    var allTitles: [String] = []
    var allDates: [String] = []
    // Image Processor Protocol Stubs
    var filePath: [String] = []
    var secureImageUrl: String = ""
    var imageSize: String = ""
    var fullImageUrl: [String] = []
    var movieImages: [UIImage] = []
    
    func mainDataRequest(completionHandler: @escaping ([String]?, [String]?, Error?) -> Void) -> Void {
        // Dispatch Groups
        let group = DispatchGroup()
        // Title
        let upcomingUrl: URL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(constant)&language=en-US&page=1")!
        let session = URLSession.shared
        let dataTaskTitle = session.dataTask(with: upcomingUrl) {
            (data, response, error) in
            guard let data = data else { print("Error with Data, \(error.debugDescription)"); return }
            do {
                let nowPlaying = try JSONDecoder().decode(MovieModelWithDates.self, from: data)
                guard let results = nowPlaying.results else { print("Error 1, \(error.debugDescription)"); return }
                self.allTitles.removeAll()
                group.enter()
                for titles in results {
                    self.allTitles.append(titles.title)
                }
                group.leave()
                // Release Date
                let releaseDateSession = URLSession.shared
                let dataTaskReleaseDate = releaseDateSession.dataTask(with: upcomingUrl) {
                    (data, response, error) in
                    guard let data = data else { print("Error with Data, \(error.debugDescription)"); return }
                    do {
                        let nowPlaying = try JSONDecoder().decode(MovieModelWithDates.self, from: data)
                        guard let results = nowPlaying.results else { print("Error 2, \(error.debugDescription)"); return }
                        self.allDates.removeAll()
                        group.enter()
                        for dates in results {
                            self.allDates.append(dates.release_date)
                        }
                        group.leave()
                        group.wait()
                        completionHandler(self.allTitles, self.allDates, nil)
                    } catch let JSONError { completionHandler(nil, nil, JSONError) }
                }
                dataTaskReleaseDate.resume()
            } catch let JSONError { completionHandler(nil, nil, JSONError) }
        }
        dataTaskTitle.resume()
    }
    
    // MARK: - Fix Error 4
    func filePathRequest(completionHandler: @escaping ([String]?, Error?) -> Void) -> Void {
        let group = DispatchGroup()
        let upcomingProcessUrl: URL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(constant)&language=en-US&page=1")!
        let session = URLSession.shared
        let imageDataTask = session.dataTask(with: upcomingProcessUrl) {
            (data, response, error) in
            guard let data = data else { print("Error 3, \(error.debugDescription)"); return }
            do {
                let nowPlayingModel = try JSONDecoder().decode(MovieModelWithDates.self, from: data)
                guard let results = nowPlayingModel.results else { print("Error 4, \(error.debugDescription)"); return }
                self.filePath.removeAll()
                group.enter()
                for filePaths in results {
                    self.filePath.append(filePaths.poster_path ?? " ")
                }
                group.leave()
                group.wait()
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
            guard let data = data else { print("Error 5, \(error.debugDescription)"); return }
            do {
                let imageProcessor = try JSONDecoder().decode(BaseImageModel.self, from: data)
                group.enter()
                self.secureImageUrl = imageProcessor.images.secure_base_url
                self.imageSize = imageProcessor.images.poster_sizes[4]
                for filePath in self.filePath {
                    self.fullImageUrl.append("\(self.secureImageUrl)\(self.imageSize)\(filePath)")
                }
                group.leave()
                group.wait()
                completionHandler(self.fullImageUrl, nil)
            } catch let JSONError { completionHandler(nil, JSONError) }
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
                group.wait()
                completionHandler(self.movieImages, nil)
            } catch let ImageError { completionHandler(nil, ImageError) }
        }
    }
    
    
} // Class End
