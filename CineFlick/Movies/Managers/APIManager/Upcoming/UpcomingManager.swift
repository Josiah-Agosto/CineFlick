//
//  UpcomingManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/19/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class UpcomingManager {
    // References / Properties
    private lazy var manager = APINetworkManager.shared
    // MARK: Main Request
    public func fetchUpcomingFeed(if error: @escaping(Result<Void, APIError>) -> Void) {
        manager.mainGroup.enter()
        manager.client.getFeed(from: .upcoming) { (result) in
            switch result {
            case .success(let upcomingFeedResult):
                defer { self.manager.mainGroup.leave() }
                guard let upcomingResult = upcomingFeedResult?.results else { return }
                for titles in upcomingResult {
                    self.manager.upcomingTitles.append(titles.title ?? "nil")
                }
                for filePaths in upcomingResult {
                    self.manager.upcomingFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for ratings in upcomingResult {
                    let rating = Int(ratings.vote_average ?? 0)
                    self.manager.upcomingRatings.append(String(rating * 10))
                }
                for ids in upcomingResult {
                    let id = "\(ids.id ?? 0)"
                    self.manager.upcomingIds.append(id)
                }
                for backdrop in upcomingResult {
                    self.manager.upcomingBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                }
                for overview in upcomingResult {
                    self.manager.upcomingOverview.append(overview.overview ?? "nil")
                }
                for dates in upcomingResult {
                    guard let releasedDate = dates.release_date else { return }
                    self.manager.upcomingReleases.append(self.manager.dateReference.convertStringToDate(dateString: releasedDate))
                }
            case .failure(_):
                error(.failure(.requestFailed))
            }
        }
    }
    
    // MARK: Poster Urls
    public func createUpcomingPosterUrls() {
        manager.upcomingFilePaths.forEach({ (paths) in
            self.manager.upcomingImagesURLs.append("\(self.manager.secureBaseUrl)\(self.manager.imageSize)\(paths)")
        })
    }
    
    // MARK: Backdrop Urls
    public func createUpcomingBackdropUrls() {
        manager.upcomingBackdropPaths.forEach({ (backdrops) in
            self.manager.upcomingBackdropURLs.append("\(self.manager.secureBaseUrl)\(self.manager.backdropSize)\(backdrops)")
        })
    }
    
    // MARK: Runtime Request
    public func getUpcomingRuntime(if error: @escaping(Result<Void, APIError>) -> Void) {
        manager.upcomingIds.forEach({ (ids) in
            self.manager.detailClient = DetailClient()
            self.manager.detailClient.detailRequest(with: ids, completion: { (result) in
                switch result {
                case .success(let detailResult):
                    guard let upcomingRuntime = detailResult?.runtime else { return }
                    let runtime = "\(upcomingRuntime)m"
                    self.manager.upcomingRuntime.append(runtime)
                case .failure(_):
                    error(.failure(.requestFailed))
                }
            })
        })
    }

}
