//
//  PopularManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/19/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class PopularManager {
    // References / Properties
    private lazy var manager = APINetworkManager.shared
    // MARK: Main Request
    public func fetchPopularFeed(if error: @escaping(Result<Void, APIError>) -> Void) {
        manager.mainGroup.enter()
        manager.client.getFeed(from: .popular) { (result) in
            switch result {
            case .success(let popularFeedResult):
                defer { self.manager.mainGroup.leave() }
                guard let popularResult = popularFeedResult?.results else { return }
                for titles in popularResult {
                    self.manager.popularTitles.append(titles.title ?? "nil")
                }
                for filePaths in popularResult {
                    self.manager.popularFilePaths.append(filePaths.poster_path ?? "nil")
                }
                for ids in popularResult {
                    let id = "\(ids.id ?? 0)"
                    self.manager.popularIds.append(id)
                }
                for backdrop in popularResult {
                    self.manager.popularBackdropPaths.append(backdrop.backdrop_path ?? "nil")
                }
                for overview in popularResult {
                    self.manager.popularOverview.append(overview.overview ?? "nil")
                }
                for ratings in popularResult {
                    let rating = Int(ratings.vote_average ?? 0)
                    self.manager.popularRatings.append(String(rating * 10))
                }
                for release in popularResult {
                    guard let releases = release.release_date else { return }
                    self.manager.popularRelease.append(self.manager.dateReference.convertStringToDate(dateString: releases))
                }
            case .failure(_):
                error(.failure(.requestFailed))
            }
        }
    }
    
    // MARK: Poster Urls
    public func createPopularPosterUrls() {
        manager.popularFilePaths.forEach({ (paths) in
            print(paths)
            self.manager.popularImagesURLs.append("\(self.manager.secureBaseUrl)\(self.manager.imageSize)\(paths)")
        })
    }
    
    // MARK: Backdrop Urls
    public func createPopularBackdropUrls() {
        manager.popularBackdropPaths.forEach({ (backdrops) in
            self.manager.popularBackdropURLs.append("\(self.manager.secureBaseUrl)\(self.manager.backdropSize)\(backdrops)")
        })
    }
    
    // MARK: Runtime Request
    public func getPopularRuntime(if error: @escaping(Result<Void, APIError>) -> Void) {
        manager.popularIds.forEach({ (ids) in
            self.manager.detailClient = DetailClient()
            self.manager.detailClient.detailRequest(with: ids, completion: { (result) in
                switch result {
                case .success(let detailResult):
                    guard let popularRuntime = detailResult?.runtime else { return }
                    let runtime = "\(popularRuntime)m"
                    self.manager.popularRuntime.append(runtime)
                case .failure(_):
                    error(.failure(.requestFailed))
                }
            })
        })
    }
    
}
