//
//  APINetworkManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class APINetworkManager {
    // References / Properties
    static var shared = APINetworkManager()
    public lazy var client = MovieClient()
    public lazy var configurationManager = ConfigurationManager.shared
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
    private let mainOperation = DispatchQueue.global(qos: .default)
    private let urlOperation = OperationQueue()

    public func makeApiRequest(completion: @escaping(Result<Void, APIError>) -> Void) {
        // Main Requests
        mainRequests(completion: completion)
        urlOperation.addOperation {
            self.mainGroup.wait()
            // Poster Urls
            self.createPosterUrls()
            // Backdrop Urls
            self.createBackdropUrls()
            // Notifier
            self.mainGroup.notify(queue: .global()) {
                completion(.success(()))
                self.updater?()
            }
        }
    }
    
    // MARK: - Main Requests
    private func mainRequests(completion: @escaping(Result<Void, APIError>) -> Void) {
        mainOperation.async {
            // Popular
            self.popularManager.fetchPopularFeed(if: completion)
            // Now Playing
            self.nowPlayingManager.fetchNowPlayingFeed(if: completion)
            // Upcoming
            self.upcomingManager.fetchUpcomingFeed(if: completion)
            // Top Rated
            self.topRatedManager.fetchTopRatedFeed(if: completion)
            // Generate Images
            self.configurationManager.fetchImages()
        }
    }
    
    // MARK: - Poster Urls
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
    
    // MARK: - Backdrop Urls
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
    
    // MARK: - Remove all Elements
    public func resetAllElements() {
        // Popular
        popularManager.removeAllPopularElements()
        // Now Playing
        nowPlayingManager.removeAllNowPlayingElements()
        // Upcoming
        upcomingManager.removeAllUpcomingElements()
        // Top Rated
        topRatedManager.removeAllTopRatedElements()
    }
    
    // MARK: - Runtime Request
    public func getRuntime(with id: String, completion: @escaping((String) -> Void)) {
        detailClient = DetailClient()
        detailClient.detailRequest(with: id) { (result) in
            switch result {
            case .success(let detailResult):
                guard let popularRuntime = detailResult?.runtime else { return }
                let convertedRuntime = self.convertMinutesToHours(with: popularRuntime)
                completion(convertedRuntime)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Minutes to Hours Conversion
    public func convertMinutesToHours(with minutes: Int) -> String {
        let hours = minutes / 60
        let convertedMinutes = minutes % 60
        let fullTimeInString = "\(hours)h \(convertedMinutes)m"
        return fullTimeInString
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
    
    
    func convertDateToAge(date: String) -> String {
        let formatter = DateFormatter()
        let today = Date()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let birthdate = formatter.date(from: date) else { return "" }
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.year], from: birthdate, to: today)
        guard let ageInYears = dateComponent.year else { return "" }
        return String(ageInYears)
    }
}
