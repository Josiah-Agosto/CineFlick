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
    static var shared = APINetworkManager()
    private var client: MovieClient!
    private var imageClient: ImageClient!
    private var detailClient: DetailClient!
    private let dateReference = Date()
    private let imageReference = UIImageView()
// MARK: - Variables
    // Popular
    var popularTitles: [String] = [] { didSet { updater?() } }
    private var popularFilePaths: [String] = [] { didSet { updater?() } } //
    var popularRatings: [String] = [] { didSet { updater?() } }
    var popularIds: [String] = [] { didSet { updater?() } }
    var popularOverview: [String] = [] { didSet { updater?() } }
    var popularRuntime: [String] = [] { didSet { updater?() } }
    var popularRelease: [String] = [] { didSet { updater?() } }
    private var popularBackdropPaths: [String] = [] { didSet { updater?() } } //
    private var popularBackdropURLs: [String] = [] { didSet { updater?() } } //
    var popularBackdropImages: [UIImage] = [] { didSet { updater?() } }
    private var popularImagesURLs: [String] = [] { didSet { updater?() } } //
    var popularImages: [UIImage] = [] { didSet { updater?() } }
    // Now Playing
    var nowPlayingTitles: [String] = [] { didSet { updater?() } }
    private var nowPlayingFilePaths: [String] = [] { didSet { updater?() } } //
    var nowPlayingReleases: [String] = [] { didSet { updater?() } }
    var nowPlayingRatings: [String] = [] { didSet { updater?() } }
    var nowPlayingIds: [String] = [] { didSet { updater?() } }
    var nowPlayingOverview: [String] = [] { didSet { updater?() } }
    var nowPlayingRuntime: [String] = [] { didSet { updater?() } }
    private var nowPlayingBackdropPaths: [String] = [] { didSet { updater?() } } //
    private var nowPlayingBackdropURLs: [String] = [] { didSet { updater?() } } //
    var nowPlayingBackdropImages: [UIImage] = [] { didSet { updater?() } }
    private var nowPlayingImagesURLs: [String] = [] { didSet { updater?() } } //
    var nowPlayingImages: [UIImage] = [] { didSet { updater?() } }
    // Upcoming
    var upcomingTitles: [String] = [] { didSet { updater?() } }
    private var upcomingFilePaths: [String] = [] { didSet { updater?() } } //
    var upcomingReleases: [String] = [] { didSet { updater?() } }
    var upcomingRatings: [String] = [] { didSet { updater?() } }
    var upcomingIds: [String] = [] { didSet { updater?() } }
    var upcomingOverview: [String] = [] { didSet { updater?() } }
    var upcomingRuntime: [String] = [] { didSet { updater?() } }
    private var upcomingBackdropPaths: [String] = [] { didSet { updater?() } } //
    private var upcomingBackdropURLs: [String] = [] { didSet { updater?() } } //
    var upcomingBackdropImages: [UIImage] = [] { didSet { updater?() } }
    private var upcomingImagesURLs: [String] = [] { didSet { updater?() } } //
    var upcomingImages: [UIImage] = [] { didSet { updater?() } }
    // Top Rated
    var topRatedTitles: [String] = [] { didSet { updater?() } }
    private var topRatedFilePaths: [String] = [] { didSet { updater?() } } //
    var topRatedReleases: [String] = [] { didSet { updater?() } }
    var topRatedRatings: [String] = [] { didSet { updater?() } }
    var topRatedIds: [String] = [] { didSet { updater?() } }
    var topRatedOverview: [String] = [] { didSet { updater?() } }
    var topRatedRuntime: [String] = [] { didSet { updater?() } }
    private var topRatedBackdropPaths: [String] = [] { didSet { updater?() } } //
    private var topRatedBackdropURLs: [String] = [] { didSet { updater?() } } //
    var topRatedBackdropImages: [UIImage] = [] { didSet { updater?() } }
    private var topRatedImagesURLs: [String] = [] { didSet { updater?() } } //
    var topRatedImages: [UIImage] = [] { didSet { updater?() } }
    // Image Variables
    private var secureBaseUrl: String = ""
    private var imageSize: String = ""
    private var backdropSize: String = ""
    // Empty Closure
    var updater: (()->())? = nil
    // Group
    private let group = DispatchGroup()
    // MARK: - Requests
    public func makeApiRequest(completion: @escaping () -> Void) -> Void {
        let operation = OperationQueue()
        let imageCreationQueue = OperationQueue()
        // Popular
        operation.addOperation {
            self.group.enter()
            self.client = MovieClient()
            self.client.getFeed(from: .popular) { (result) in
                switch result {
                case .success(let popularFeedResult):
                    defer { self.group.leave() }
                    guard let popularResult = popularFeedResult?.results else { return }
                    for titles in popularResult {
                        self.popularTitles.append(titles.title ?? "nil")
                    }
                    for filePaths in popularResult {
                        self.popularFilePaths.append(filePaths.poster_path ?? "nil")
                    }
                    for ids in popularResult {
                        let id = "\(ids.id ?? 0)"
                        self.popularIds.append(id)
                    }
                    for backdrop in popularResult {
                        self.popularBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                    }
                    for overview in popularResult {
                        self.popularOverview.append(overview.overview ?? "nil")
                    }
                    for ratings in popularResult {
                        let rating = Int(ratings.vote_average ?? 0)
                        self.popularRatings.append(String(rating * 10))
                    }
                    for release in popularResult {
                        guard let releases = release.release_date else { return }
                        self.popularRelease.append(self.dateReference.convertStringToDate(dateString: releases))
                    }
                case .failure(let error):
                    print("Popular: \(error)")
                }
            }
            // Now Playing
            self.group.enter()
            self.client.getFeed(from: .nowPlaying) { (result) in
                switch result {
                case.success(let nowPlayingFeedResult):
                    defer { self.group.leave() }
                    guard let nowPlayingResult = nowPlayingFeedResult?.results else { return }
                    for titles in nowPlayingResult {
                        self.nowPlayingTitles.append(titles.title ?? "nil")
                    }
                    for filePaths in nowPlayingResult {
                        self.nowPlayingFilePaths.append(filePaths.poster_path ?? "nil")
                    }
                    for ids in nowPlayingResult {
                        let id = "\(ids.id ?? 0)"
                        self.nowPlayingIds.append(id)
                    }
                    for ratings in nowPlayingResult {
                        let rating = Int(ratings.vote_average ?? 0)
                        self.nowPlayingRatings.append(String(rating * 10))
                    }
                    for backdrop in nowPlayingResult {
                        self.nowPlayingBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                    }
                    for overview in nowPlayingResult {
                        self.nowPlayingOverview.append(overview.overview ?? "nil")
                    }
                    for dates in nowPlayingResult {
                        guard let releasedDate = dates.release_date else { return }
                        self.nowPlayingReleases.append(self.dateReference.convertStringToDate(dateString: releasedDate))
                    }
                case .failure(let error):
                    print("Now Playing: \(error)")
                }
            }
            // Upcoming
            self.group.enter()
            self.client.getFeed(from: .upcoming) { (result) in
                switch result {
                case .success(let upcomingFeedResult):
                    defer { self.group.leave() }
                    guard let upcomingResult = upcomingFeedResult?.results else { return }
                    for titles in upcomingResult {
                        self.upcomingTitles.append(titles.title ?? "nil")
                    }
                    for filePaths in upcomingResult {
                        self.upcomingFilePaths.append(filePaths.poster_path ?? "nil")
                    }
                    for ratings in upcomingResult {
                        let rating = Int(ratings.vote_average ?? 0)
                        self.upcomingRatings.append(String(rating * 10))
                    }
                    for ids in upcomingResult {
                        let id = "\(ids.id ?? 0)"
                        self.upcomingIds.append(id)
                    }
                    for backdrop in upcomingResult {
                        self.upcomingBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                    }
                    for overview in upcomingResult {
                        self.upcomingOverview.append(overview.overview ?? "nil")
                    }
                    for dates in upcomingResult {
                        guard let releasedDate = dates.release_date else { return }
                        self.upcomingReleases.append(self.dateReference.convertStringToDate(dateString: releasedDate))
                    }
                case .failure(let error):
                    print("Upcoming: \(error)")
                }
            }
            // Top Rated
            self.group.enter()
            self.client.getFeed(from: .topRated) { (result) in
                switch result {
                case .success(let topRatedFeedResult):
                    defer { self.group.leave() }
                    guard let topRatedResult = topRatedFeedResult?.results else { return }
                    for titles in topRatedResult {
                        self.topRatedTitles.append(titles.title ?? "nil")
                    }
                    for filePaths in topRatedResult {
                        self.topRatedFilePaths.append(filePaths.poster_path ?? "nil")
                    }
                    for ratings in topRatedResult {
                        let rating = Int(ratings.vote_average ?? 0)
                        self.topRatedRatings.append(String(rating * 10))
                    }
                    for ids in topRatedResult {
                        let id = "\(ids.id ?? 0)"
                        self.topRatedIds.append(id)
                    }
                    for backdrop in topRatedResult {
                        self.topRatedBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                    }
                    for overview in topRatedResult {
                        self.topRatedOverview.append(overview.overview ?? "nil")
                    }
                    for dates in topRatedResult {
                        guard let releasedDate = dates.release_date else { return }
                        self.topRatedReleases.append(self.dateReference.convertStringToDate(dateString: releasedDate))
                    }
                case .failure(let error):
                    print("Top Rated: \(error)")
                }
            }
            // Create Image Model
            self.group.enter()
            self.imageClient = ImageClient()
            self.imageClient.createImage(from: .configure, completion: { (imageResult) in
                switch imageResult {
                case .success(let imageFeedResult):
                    defer { self.group.leave() }
                    guard let imageCreation = imageFeedResult?.images else { return }
                    guard let secure = imageCreation.secure_base_url else { return }
                    guard let posterSize = imageCreation.poster_sizes?[4] else { return }
                    guard let backdropSize = imageCreation.backdrop_sizes?[2] else { return }
                    self.secureBaseUrl = secure
                    self.imageSize = posterSize
                    self.backdropSize = backdropSize
                case .failure(let error):
                    print("Image Creation: \(error)")
                }
            })
        }
        // Worked on 09/21/2019 9:44PM
        imageCreationQueue.addOperation {
            self.group.wait()
    // MARK: - Creating the URL's
        // MARK: - Poster
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
        // MARK: - For Detail View
            // Backdrops
            // Popular
            self.popularBackdropPaths.forEach({ (backdrops) in
                self.popularBackdropURLs.append("\(self.secureBaseUrl)\(self.backdropSize)\(backdrops)")
            })
            // Now Playing
            self.nowPlayingBackdropPaths.forEach({ (backdrops) in
                self.nowPlayingBackdropURLs.append("\(self.secureBaseUrl)\(self.backdropSize)\(backdrops)")
            })
            // Upcoming
            self.upcomingBackdropPaths.forEach({ (backdrops) in
                self.upcomingBackdropURLs.append("\(self.secureBaseUrl)\(self.backdropSize)\(backdrops)")
            })
            // Top Rated
            self.topRatedBackdropPaths.forEach({ (backdrops) in
                self.topRatedBackdropURLs.append("\(self.secureBaseUrl)\(self.backdropSize)\(backdrops)")
            })
            // Runtime
            // Popular
            self.popularIds.forEach({ (ids) in
                self.detailClient = DetailClient()
                self.detailClient.detailRequest(with: ids, completion: { (result) in
                    switch result {
                    case .success(let detailResult):
                        guard let popularRuntime = detailResult?.runtime else { return }
                        let runtime = "\(popularRuntime)m"
                        self.popularRuntime.append(runtime)
                    case .failure(let error):
                        print("Popular Id's: \(error)")
                    }
                })
            })
            // Now Playing
            self.nowPlayingIds.forEach({ (ids) in
                self.detailClient = DetailClient()
                self.detailClient.detailRequest(with: ids, completion: { (result) in
                    switch result {
                    case .success(let detailResult):
                        guard let nowPlayingRuntime = detailResult?.runtime else { return }
                        let runtime = "\(nowPlayingRuntime)m"
                        self.nowPlayingRuntime.append(runtime)
                    case .failure(let error):
                        print("Now Playing id's: \(error)")
                    }
                })
            })
            // Upcoming
            self.upcomingIds.forEach({ (ids) in
                self.detailClient = DetailClient()
                self.detailClient.detailRequest(with: ids, completion: { (result) in
                    switch result {
                    case .success(let detailResult):
                        guard let upcomingRuntime = detailResult?.runtime else { return }
                        let runtime = "\(upcomingRuntime)m"
                        self.upcomingRuntime.append(runtime)
                    case .failure(let error):
                        print("Upcoming Id's: \(error)")
                    }
                })
            })
            // Top Rated
            self.topRatedIds.forEach({ (ids) in
                self.detailClient = DetailClient()
                self.detailClient.detailRequest(with: ids, completion: { (result) in
                    switch result {
                    case .success(let detailResult):
                        guard let topRatedRuntime = detailResult?.runtime else { return }
                        let runtime = "\(topRatedRuntime)m"
                        self.topRatedRuntime.append(runtime)
                    case .failure(let error):
                        print("Top Rated Id's: \(error)")
                    }
                })
            })
    // MARK: - Creating the UIImage
        // MARK: - Poster
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
        // MARK: - Backdrop
            // Popular
            self.popularBackdropURLs.forEach({ (backUrls) in
                self.popularBackdropImages.append(self.imageReference.convertUrlToImage(with: backUrls))
            })
            // Now Playing
            self.nowPlayingBackdropURLs.forEach({ (backUrls) in
                self.nowPlayingBackdropImages.append(self.imageReference.convertUrlToImage(with: backUrls))
            })
            // Upcoming
            self.upcomingBackdropURLs.forEach({ (backUrls) in
                self.upcomingBackdropImages.append(self.imageReference.convertUrlToImage(with: backUrls))
            })
            // Top Rated
            self.topRatedBackdropURLs.forEach({ (backUrls) in
                self.topRatedBackdropImages.append(self.imageReference.convertUrlToImage(with: backUrls))
            })
            self.group.notify(queue: DispatchQueue.main) {
                completion()
                self.updater?()
            }
        }
    } // API Func End
    
    // URL with Id's
    private func urlWithIds(id of: String) -> URL {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(of)?api_key=\(apiKey)&language=en-US")!
        return url
    }
} // Class End


// MARK: - String to Date Extension
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


// MARK: - String to Image Extension
// Is used for both Home and Detail Colleciton Views
extension UIImageView {
    func convertUrlToImage(with url: String) -> UIImage {
        DispatchQueue.main.async {
            self.image = nil
        }
        guard let url = URL(string: url) else { print("Not Valid URL"); return UIImage() }
        do {
            let data = try Data(contentsOf: url)
            let image: UIImage = UIImage(data: data)!
            return image
        } catch let error { print(error) }
        // If it doesn't work then this will return
        return UIImage(named: "ImageNotFound")!
    }
}
