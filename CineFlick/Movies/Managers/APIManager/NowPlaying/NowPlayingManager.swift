//
//  NowPlayingManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/19/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class NowPlayingManager {
    // References / Properties
    private lazy var manager = APINetworkManager.shared
    // MARK: - Main Request
    public func fetchNowPlayingFeed(if error: @escaping(Result<Void, APIError>) -> Void) {
        manager.mainGroup.enter()
        manager.client.getFeed(from: .nowPlaying) { (result) in
            switch result {
            case.success(let nowPlayingFeedResult):
                defer { self.manager.mainGroup.leave() }
                guard let nowPlayingResult = nowPlayingFeedResult?.results else { return }
                for titles in nowPlayingResult {
                    self.manager.nowPlayingTitles.append(titles.title ?? "nil")
                }
                for filePaths in nowPlayingResult {
                    self.manager.nowPlayingFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for ids in nowPlayingResult {
                    let id = "\(ids.id ?? 0)"
                    self.manager.nowPlayingIds.append(id)
                }
                for ratings in nowPlayingResult {
                    let rating = Int(ratings.vote_average ?? 0)
                    self.manager.nowPlayingRatings.append(String(rating * 10))
                }
                for backdrop in nowPlayingResult {
                    self.manager.nowPlayingBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                }
                for overview in nowPlayingResult {
                    self.manager.nowPlayingOverview.append(overview.overview ?? "nil")
                }
                for dates in nowPlayingResult {
                    guard let releasedDate = dates.release_date else { return }
                    self.manager.nowPlayingReleases.append(self.manager.dateReference.convertStringToDate(dateString: releasedDate))
                }
            case .failure(_):
                error(.failure(.requestFailed))
            }
        }
    }
    
    // MARK: - Poster Urls
    public func createNowPlayingPosterUrls() {
        manager.nowPlayingFilePaths.forEach({ (paths) in
            self.manager.nowPlayingImagesURLs.append("\(self.manager.secureBaseUrl)\(self.manager.imageSize)\(paths)")
        })
    }

    // MARK: - Backdrop Urls
    public func createNowPlayingBackdropUrls() {
        manager.nowPlayingBackdropPaths.forEach({ (backdrops) in
            self.manager.nowPlayingBackdropURLs.append("\(self.manager.secureBaseUrl)\(self.manager.backdropSize)\(backdrops)")
        })
    }
    
    // MARK: - Removes all Elements
    public func removeAllNowPlayingElements() {
        manager.nowPlayingIds.removeAll()
        manager.nowPlayingImages.removeAll()
        manager.nowPlayingTitles.removeAll()
        manager.nowPlayingRatings.removeAll()
        manager.nowPlayingReleases.removeAll()
        manager.nowPlayingOverview.removeAll()
        manager.nowPlayingFilePaths.removeAll()
        manager.nowPlayingImagesURLs.removeAll()
        manager.nowPlayingBackdropURLs.removeAll()
        manager.nowPlayingBackdropPaths.removeAll()
        manager.nowPlayingBackdropImages.removeAll()
    }
    
}
