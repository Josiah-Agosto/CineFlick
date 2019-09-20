//
//  APINetworkManager.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class APINetworkManager {
// Reference
    private let client = MovieClient()
    private let imageClient = ImageClient()
    private let dateReference = Date()
    private let imageReference = UIImage()
// Variables
    // Popular
    var popularTitles: [String] = [] { didSet { updater?() } }
    var popularFilePaths: [String] = [] { didSet { updater?() } }
    var popularRatings: [String] = [] { didSet { updater?() } }
    var popularImagesURLs: [String] = [] { didSet { updater?() } }
    var popularImages: [UIImage] = [] { didSet { updater?() } }
    // Now Playing
    var nowPlayingTitles: [String] = [] { didSet { updater?() } }
    var nowPlayingFilePaths: [String] = [] { didSet { updater?() } }
    var nowPlayingReleases: [String] = [] { didSet { updater?() } }
    var nowPlayingImagesURLs: [String] = [] { didSet { updater?() } }
    var nowPlayingImages: [UIImage] = [] { didSet { updater?() } }
    // Upcoming
    var upcomingTitles: [String] = [] { didSet { updater?() } }
    var upcomingFilePaths: [String] = [] { didSet { updater?() } }
    var upcomingReleases: [String] = [] { didSet { updater?() } }
    var upcomingImagesURLs: [String] = [] { didSet { updater?() } }
    var upcomingImages: [UIImage] = [] { didSet { updater?() } }
    // Top Rated
    var topRatedTitles: [String] = [] { didSet { updater?() } }
    var topRatedFilePaths: [String] = [] { didSet { updater?() } }
    var topRatedReleases: [String] = [] { didSet { updater?() } }
    var topRatedImagesURLs: [String] = [] { didSet { updater?() } }
    var topRatedImages: [UIImage] = [] { didSet { updater?() } }
// Image Variables
    private var secureBaseUrl: String = ""
    private var imageSize: String = ""
// Empty Closure
    var updater: (()->())? = nil
    
    // Request
    public func makeApiRequest(completion: @escaping () -> Void) -> Void {
        // Popular
        client.getFeed(from: .popular) { (result) in
            switch result {
            case .success(let popularFeedResult):
                guard let popularResult = popularFeedResult?.results else { return }
                for titles in popularResult {
                    self.popularTitles.append(titles.title ?? "nil")
                }
                for filePaths in popularResult {
                    self.popularFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for ratings in popularResult {
                    self.popularRatings.append("\(String(describing: ratings.vote_average))")
                }
            case .failure(let error):
                print(error)
            }
        }
        // Now Playing
        client.getFeed(from: .nowPlaying) { (result) in
            switch result {
            case.success(let nowPlayingFeedResult):
                guard let nowPlayingResult = nowPlayingFeedResult?.results else { return }
                for titles in nowPlayingResult {
                    self.nowPlayingTitles.append(titles.title ?? "nil")
                }
                for filePaths in nowPlayingResult {
                    self.nowPlayingFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for dates in nowPlayingResult {
                    self.nowPlayingReleases.append(self.dateReference.convertStringToDate(dateString: dates.release_date ?? "nil"))
                }
                // Create Image Model
            case .failure(let error) :
                print(error)
            }
        }
        // Upcoming
        client.getFeed(from: .upcoming) { (result) in
            switch result {
            case .success(let upcomingFeedResult):
                guard let upcomingResult = upcomingFeedResult?.results else { return }
                for titles in upcomingResult {
                    self.upcomingTitles.append(titles.title ?? "nil")
                }
                for filePaths in upcomingResult {
                    self.upcomingFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for dates in upcomingResult {
                    self.upcomingReleases.append(self.dateReference.convertStringToDate(dateString: dates.release_date ?? "nil"))
                }
                // Create Image Model
            case .failure(let error):
                print(error)
            }
        }
        // Top Rated
        client.getFeed(from: .topRated) { (result) in
            switch result {
            case .success(let topRatedFeedResult):
                guard let topRatedResult = topRatedFeedResult?.results else { return }
                for titles in topRatedResult {
                    self.topRatedTitles.append(titles.title ?? "nil")
                }
                for filePaths in topRatedResult {
                    self.topRatedFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for dates in topRatedResult {
                    self.topRatedReleases.append(self.dateReference.convertStringToDate(dateString: dates.release_date ?? "nil"))
                }
                // Create Image Model
            case .failure(let error):
                print(error)
            }
        }
        
        // Create Image Model
        imageClient.createImage(from: .configure, completion: { (imageResult) in
            switch imageResult {
            case .success(let imageFeedResult):
                guard let imageCreation = imageFeedResult?.images else { return }
                self.secureBaseUrl = imageCreation.secure_base_url
                self.imageSize = imageCreation.poster_sizes[4]
            // MARK: - Creating the URL's
                // Popular Image URL's
                self.popularFilePaths.forEach({ (paths) in
                    self.popularImagesURLs.append("\(self.secureBaseUrl)\(self.imageSize)\(paths)")
                })
                // Now Playing Image URL's
                self.nowPlayingFilePaths.forEach({ (paths) in
                    self.nowPlayingImagesURLs.append("\(self.secureBaseUrl)\(self.imageSize)\(paths)")
                })
                // Upcoming Image URL's
                self.upcomingFilePaths.forEach({ (paths) in
                    self.upcomingImagesURLs.append("\(self.secureBaseUrl)\(self.imageSize)\(paths)")
                })
                // Top Rated Image URL's
                self.topRatedFilePaths.forEach({ (paths) in
                    self.topRatedImagesURLs.append("\(self.secureBaseUrl)\(self.imageSize)\(paths)")
                })
                
            // MARK: - Creating the UIImage
                // Popular
                self.popularImagesURLs.forEach({ (urls) in
                    self.popularImages.append(self.imageReference.convertUrlToImage(with: urls))
                })
                // Now Playing
                self.nowPlayingImagesURLs.forEach({ (urls) in
                    self.nowPlayingImages.append(self.imageReference.convertUrlToImage(with: urls))
                })
                // Upcoming
                self.upcomingImagesURLs.forEach({ (urls) in
                    self.upcomingImages.append(self.imageReference.convertUrlToImage(with: urls))
                })
                // Top Rated
                self.topRatedImagesURLs.forEach({ (urls) in
                    self.topRatedImages.append(self.imageReference.convertUrlToImage(with: urls))
                })
            case .failure(let error):
                print(error)
            }
        })
    } // API Func End
} // Class End


// Converts String to Date
extension Date {
    func convertStringToDate(dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let newDate: Date = formatter.date(from: dateString)!
        formatter.dateFormat = "yyyy"
        let stringDate: String = formatter.string(from: newDate)
        return stringDate
    }
}


// Converting String to UIImage
extension UIImage {
    func convertUrlToImage(with url: String) -> UIImage {
        let url = URL(string: url)!
        do {
            let data = try Data(contentsOf: url)
            let image: UIImage = UIImage(data: data)!
            print("Completed Image!")
            return image
        } catch let error { print(error) }
        // If it doesn't work then this will return
        return UIImage()
    }
}
