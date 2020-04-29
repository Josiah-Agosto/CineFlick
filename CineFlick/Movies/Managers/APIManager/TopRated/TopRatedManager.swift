//
//  TopRatedManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/19/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class TopRatedManager {
    // References / Properties
    private lazy var manager = APINetworkManager.shared
    // MARK: - Main Request
    public func fetchTopRatedFeed(if error: @escaping(Result<Void, APIError>) -> Void) {
        manager.mainGroup.enter()
        manager.client.getFeed(from: .topRated) { (result) in
            switch result {
            case .success(let topRatedFeedResult):
                defer { self.manager.mainGroup.leave() }
                guard let topRatedResult = topRatedFeedResult?.results else { return }
                for titles in topRatedResult {
                    self.manager.topRatedTitles.append(titles.title ?? "nil")
                }
                for filePaths in topRatedResult {
                    self.manager.topRatedFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for ratings in topRatedResult {
                    let rating = Int(ratings.vote_average ?? 0)
                    self.manager.topRatedRatings.append(String(rating * 10))
                }
                for ids in topRatedResult {
                    let id = "\(ids.id ?? 0)"
                    self.manager.topRatedIds.append(id)
                }
                for backdrop in topRatedResult {
                    self.manager.topRatedBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                }
                for overview in topRatedResult {
                    self.manager.topRatedOverview.append(overview.overview ?? "nil")
                }
                for dates in topRatedResult {
                    guard let releasedDate = dates.release_date else { return }
                    self.manager.topRatedReleases.append(self.manager.dateReference.convertStringToDate(dateString: releasedDate))
                }
            case .failure(_):
                error(.failure(.requestFailed))
            }
        }
    }
    
    // MARK: - Poster Urls
    public func createTopRatedPosterUrls() {
        manager.topRatedFilePaths.forEach({ (paths) in
            self.manager.topRatedImagesURLs.append("\(self.manager.imageManager.secureBaseUrl)\(self.manager.imageManager.imageSize)\(paths)")
        })
    }
    
    // MARK: - Backdrop Urls
    public func createTopRatedBackdropUrls() {
        manager.topRatedBackdropPaths.forEach({ (backdrops) in
            self.manager.topRatedBackdropURLs.append("\(self.manager.imageManager.secureBaseUrl)\(self.manager.imageManager.backdropSize)\(backdrops)")
        })
    }
    
    // MARK: - Removes all Elements
    public func removeAllTopRatedElements() {
        manager.topRatedIds.removeAll()
        manager.topRatedImages.removeAll()
        manager.topRatedTitles.removeAll()
        manager.topRatedRatings.removeAll()
        manager.topRatedOverview.removeAll()
        manager.topRatedReleases.removeAll()
        manager.topRatedFilePaths.removeAll()
        manager.topRatedImagesURLs.removeAll()
        manager.topRatedBackdropURLs.removeAll()
        manager.topRatedBackdropPaths.removeAll()
        manager.topRatedBackdropImages.removeAll()
    }
    
}
