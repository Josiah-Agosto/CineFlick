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
    private let constant = apiKey
    // Temporary Data Holders from JSON
    internal var allTitles: [String] = []
    internal var allDates: [String] = []
    // Image Processor Protocol Stubs
    internal var filePath: [String] = []
    internal var secureImageUrl: String = ""
    internal var imageSize: String = ""
    internal var fullImageUrl: [String] = []
    
    func mainDataRequest(completionHandler: @escaping ([String]?, [String]?, Error?) -> Void) -> Void {
        // Dispatch Groups
        let group = DispatchGroup()
        // Title
        let upcomingUrl: URL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(constant)&language=en-US&page=1&region=US")!
        let session = URLSession.shared
        let dataTaskTitle = session.dataTask(with: upcomingUrl) {
            (data, response, error) in
            guard let data = data else { print("Error with Data, \(error.debugDescription)"); return }
            do {
                let nowPlaying = try JSONDecoder().decode(MovieModelWithDates.self, from: data)
                guard let results = nowPlaying.results else { print("Error 1, \(error.debugDescription)"); return }
                group.enter()
                self.allTitles.removeAll()
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
                        group.enter()
                        self.allDates.removeAll()
                        for dates in results {
                            self.allDates.append(dates.release_date)
                        }
                        group.leave()
                        group.notify(queue: DispatchQueue.main, execute: {
                            completionHandler(self.allTitles, self.allDates, nil)
                        })
                    } catch let JSONError { completionHandler(nil, nil, JSONError); print(JSONError) }
                }
                dataTaskReleaseDate.resume()
            } catch let JSONError { completionHandler(nil, nil, JSONError); print(JSONError) }
        }
        dataTaskTitle.resume()
    }
    
    // File Path Request
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
                group.enter()
                self.filePath.removeAll()
                for filePaths in results {
                    self.filePath.append(filePaths.poster_path ?? " ")
                }
                print("Upcoming: \(self.filePath)")
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
            guard let data = data else { print("Error 5, \(error.debugDescription)"); return }
            do {
                let imageProcessor = try JSONDecoder().decode(BaseImageModel.self, from: data)
                group.enter()
                self.secureImageUrl = imageProcessor.images.secure_base_url
                self.imageSize = imageProcessor.images.poster_sizes[4]
                for filePath in self.filePath {
                    self.fullImageUrl.append("\(self.secureImageUrl)\(self.imageSize)\(filePath)")
                }
                print("Upcoming: \(self.fullImageUrl)")
                group.leave()
                group.notify(queue: DispatchQueue.main, execute: {
                    completionHandler(self.fullImageUrl, nil)
                })
            } catch let JSONError { completionHandler(nil, JSONError); print(JSONError) }
        }
        imageDataTask.resume()
    }
    
    
    func makeUrlAnImage(completionHandler: @escaping ([UIImage]?, Error?) -> Void) {
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
