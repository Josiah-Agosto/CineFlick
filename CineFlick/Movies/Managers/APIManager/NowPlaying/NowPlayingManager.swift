//
//  NowPlayingManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/19/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class NowPlayingManager {
    // References / Properties
    private lazy var manager = APINetworkManager.shared
    // MARK: Main Request
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
    
    // MARK: Poster Urls
    public func createNowPlayingPosterUrls() {
        manager.nowPlayingFilePaths.forEach({ (paths) in
            print("Should have something here, \(self.manager.secureBaseUrl)")
            self.manager.nowPlayingImagesURLs.append("\(self.manager.secureBaseUrl)\(self.manager.imageSize)\(paths)")
        })
    }

    // MARK: Backdrop Urls
    public func createNowPlayingBackdropUrls() {
        manager.nowPlayingBackdropPaths.forEach({ (backdrops) in
            self.manager.nowPlayingBackdropURLs.append("\(self.manager.secureBaseUrl)\(self.manager.backdropSize)\(backdrops)")
        })
    }
    
    // MARK: Runtime Request
    public func getNowPlayingRuntime(if error: @escaping(Result<Void, APIError>) -> Void) {
        manager.nowPlayingIds.forEach({ (ids) in
            self.manager.detailClient = DetailClient()
            self.manager.detailClient.detailRequest(with: ids, completion: { (result) in
                switch result {
                case .success(let detailResult):
                    guard let nowPlayingRuntime = detailResult?.runtime else { return }
                    let runtime = "\(nowPlayingRuntime)m"
                    self.manager.nowPlayingRuntime.append(runtime)
                case .failure(_):
                    error(.failure(.requestFailed))
                }
            })
        })
    }
    
}
