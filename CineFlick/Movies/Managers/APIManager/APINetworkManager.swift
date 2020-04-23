//
//  APINetworkManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class APINetworkManager {
    // References / Properties
    static var shared = APINetworkManager()
    public lazy var client = MovieClient()
    public lazy var imageClient = ImageClient()
    public lazy var detailClient = DetailClient()
    public let dateReference = Date()
    public lazy var imageReference = CustomImageView()
    // Popular Manager
    public let popularManager = PopularManager()
    public let nowPlayingManager = NowPlayingManager()
    public let upcomingManager = UpcomingManager()
    public let topRatedManager = TopRatedManager()
    // Popular
    var popularTitles: [String] = [] { didSet { updater?() } }
    var popularRatings: [String] = [] { didSet { updater?() } }
    var popularIds: [String] = [] { didSet { updater?() } }
    var popularOverview: [String] = [] { didSet { updater?() } }
    var popularRuntime: [String] = [] { didSet { updater?() } }
    var popularRelease: [String] = [] { didSet { updater?() } }
    var popularBackdropImages: [UIImage] = [] { didSet { updater?() } }
    var popularImages: [UIImage] = [] { didSet { updater?() } }
    var popularBackdropPaths: [String] = [] { didSet { updater?() } }
    var popularBackdropURLs: [String] = [] { didSet { updater?() } }
    var popularImagesURLs: [String] = [] { didSet { updater?() } }
    var popularFilePaths: [String] = [] { didSet { updater?() } }
    // Now Playing
    var nowPlayingTitles: [String] = [] { didSet { updater?() } }
    var nowPlayingReleases: [String] = [] { didSet { updater?() } }
    var nowPlayingRatings: [String] = [] { didSet { updater?() } }
    var nowPlayingIds: [String] = [] { didSet { updater?() } }
    var nowPlayingOverview: [String] = [] { didSet { updater?() } }
    var nowPlayingRuntime: [String] = [] { didSet { updater?() } }
    var nowPlayingBackdropImages: [UIImage] = [] { didSet { updater?() } }
    var nowPlayingImages: [UIImage] = [] { didSet { updater?() } }
    var nowPlayingBackdropPaths: [String] = [] { didSet { updater?() } }
    var nowPlayingBackdropURLs: [String] = [] { didSet { updater?() } }
    var nowPlayingImagesURLs: [String] = [] { didSet { updater?() } }
    var nowPlayingFilePaths: [String] = [] { didSet { updater?() } }
    // Upcoming
    var upcomingTitles: [String] = [] { didSet { updater?() } }
    var upcomingReleases: [String] = [] { didSet { updater?() } }
    var upcomingRatings: [String] = [] { didSet { updater?() } }
    var upcomingIds: [String] = [] { didSet { updater?() } }
    var upcomingOverview: [String] = [] { didSet { updater?() } }
    var upcomingRuntime: [String] = [] { didSet { updater?() } }
    var upcomingBackdropImages: [UIImage] = [] { didSet { updater?() } }
    var upcomingImages: [UIImage] = [] { didSet { updater?() } }
    var upcomingBackdropPaths: [String] = [] { didSet { updater?() } }
    var upcomingBackdropURLs: [String] = [] { didSet { updater?() } }
    var upcomingImagesURLs: [String] = [] { didSet { updater?() } }
    var upcomingFilePaths: [String] = [] { didSet { updater?() } }
    // Top Rated
    var topRatedTitles: [String] = [] { didSet { updater?() } }
    var topRatedReleases: [String] = [] { didSet { updater?() } }
    var topRatedRatings: [String] = [] { didSet { updater?() } }
    var topRatedIds: [String] = [] { didSet { updater?() } }
    var topRatedOverview: [String] = [] { didSet { updater?() } }
    var topRatedRuntime: [String] = [] { didSet { updater?() } }
    var topRatedImages: [UIImage] = [] { didSet { updater?() } }
    var topRatedBackdropImages: [UIImage] = [] { didSet { updater?() } }
    var topRatedBackdropPaths: [String] = [] { didSet { updater?() } }
    var topRatedBackdropURLs: [String] = [] { didSet { updater?() } }
    var topRatedImagesURLs: [String] = [] { didSet { updater?() } }
    var topRatedFilePaths: [String] = [] { didSet { updater?() } }
    // Image Variables
    public var secureBaseUrl = ""
    public var imageSize = ""
    public var backdropSize = ""
    // Updater
    private var updater: (()->())? = nil
    // Multi-Threading
    public let mainGroup = DispatchGroup()
    private let mainOperation = OperationQueue()
    private let finishingOperation = OperationQueue()
    private let queue = DispatchQueue(label: "mainRequests")

    public func makeApiRequest(completion: @escaping(Result<Void, APIError>) -> Void) {
        // Main Requests
        mainRequests(completion: completion)
        finishingOperation.addOperation {
            self.mainGroup.wait()
            // Poster Urls
            self.createPosterUrls()
            // Backdrop Urls
            self.createBackdropUrls()
            // Runtime Requests
            self.createRuntimeRequest(completion: completion)
            // Notify Queue
            self.mainGroup.notify(queue: DispatchQueue.main) {
                completion(.success(()))
                self.updater?()
            }
        }
    }
    
    // MARK: Main Requests
    private func mainRequests(completion: @escaping(Result<Void, APIError>) -> Void) {
        queue.async {
            // Popular
            self.popularManager.fetchPopularFeed(if: completion)
            // Now Playing
            self.nowPlayingManager.fetchNowPlayingFeed(if: completion)
            // Upcoming
            self.upcomingManager.fetchUpcomingFeed(if: completion)
            // Top Rated
            self.topRatedManager.fetchTopRatedFeed(if: completion)
            // Generate Images
            self.generateImages(if: completion)
        }
    }
    
    // MARK: Generate Image
    private func generateImages(if error: @escaping(Result<Void, APIError>) -> Void) {
        mainGroup.enter()
        imageClient.createImage(from: .configure) { (result) in
            switch result {
            case .success(let imageFeedResult):
                defer { self.mainGroup.leave() }
                guard let imageCreation = imageFeedResult?.images else { return }
                guard let secure = imageCreation.secure_base_url else { return }
                guard let posterSize = imageCreation.poster_sizes?[4] else { return }
                guard let backdropSize = imageCreation.backdrop_sizes?[2] else { return }
                self.secureBaseUrl = secure
                self.imageSize = posterSize
                self.backdropSize = backdropSize
            case .failure(_):
                error(.failure(.requestFailed))
            }
        }
    }
    
    // MARK: Poster Urls
    private func createPosterUrls() {
        // Popular
        popularManager.createPopularPosterUrls()
        // Now Playing
        nowPlayingManager.createNowPlayingPosterUrls()
        // Upcoming
        upcomingManager.createUpcomingPosterUrls()
        // Top Rated
        topRatedManager.createTopRatedPosterUrls()
    }
    
    // MARK: Backdrop Urls
    private func createBackdropUrls() {
        // Popular
        popularManager.createPopularBackdropUrls()
        // Now Playing
        nowPlayingManager.createNowPlayingBackdropUrls()
        // Upcoming
        upcomingManager.createUpcomingBackdropUrls()
        // Top Rated
        topRatedManager.createTopRatedBackdropUrls()
    }
    
    // MARK: Runtime
    private func createRuntimeRequest(completion: @escaping(Result<Void, APIError>) -> Void) {
        // Popular
        popularManager.getPopularRuntime(if: completion)
        // Now Playing
        nowPlayingManager.getNowPlayingRuntime(if: completion)
        // Upcoming
        upcomingManager.getUpcomingRuntime(if: completion)
        // Top Rated
        topRatedManager.getTopRatedRuntime(if: completion)
    }
    
} // Class End


// MARK: String to Date Extension
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
