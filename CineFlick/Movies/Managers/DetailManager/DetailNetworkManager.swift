//
//  DetailNetworkManager.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class DetailNetworkManager {
    // Properties
    static let shared = DetailNetworkManager()
    // Cast Properties
    private var path: [String] = [] { didSet { updater?() } }
    public var fullPath: [String] = [] { didSet { updater?() } }
    public var personIdArray: [String] = [] { didSet { updater?() } }
    // Search Detail Properties
    public var backdropPath: String = "" { didSet { updater?() } }
    public var overview: String = "" { didSet { updater?() } }
    public var releaseDate: String = "" { didSet { updater?() } }
    // Video Properties
    public var videos: Int = 0 { didSet { updater?() } }
    public var videoTitle: [String] = [] { didSet { updater?() } }
    public var videoId: [String] = [] { didSet { updater?() } }
    public var videoKey: [String] = [] { didSet { updater?() } }
    public var videoSize: [String] = [] { didSet { updater?() } }
    public var videoSite: [String] = [] { didSet { updater?() } }
    // Thumbnail Properties
    public var thumbnailUrls: [String] = [] { didSet { updater?() } }
    // Reference
    private let castClient = CastClient()
    private let detailClient = DetailClient()
    private let thumbnailClient = ThumbnailClient()
    private let configurationManager = ConfigurationManager.shared
    private let group = DispatchGroup()
    private var updater: (() -> ())? = nil
    private let detailQueue = DispatchQueue.global(qos: .default)
    private let mainRequestOperation = DispatchQueue.global(qos: .default)
    private let finishingOperation = OperationQueue()
    // Delegate
    public weak var castPropertiesDelegate: CastDataSourceProtocol?
    // MARK: - Requests
    public func detailCast(_ id: String, completion: @escaping (Result<Void, APIError>) -> Void) -> Void {
        castRequest(with: id) { (result) in
            switch result {
            case .success():
                defer { completion(.success(())); self.updater?() }
                self.path.forEach { (path) in
                    self.fullPath.append("\(self.configurationManager.secureBaseUrl)\(self.configurationManager.imageSize)\(path)")
                }
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }
        group.notify(queue: .main, execute: {
            completion(.success(()))
            self.updater?()
        })
    } // Func End
    
    // MARK: - Cast Request
    private func castRequest(with id: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        group.enter()
        configurationManager.fetchImages()
        castClient.castRequest(with: id) { (result) in
            defer { self.group.leave() }
            switch result {
            case .success(let castFromResult):
                defer { completion(.success(())); self.updater?() }
                guard let castArray = castFromResult?.cast else { return }
                self.castPropertiesDelegate?.castCountForSection = castArray.count
                for perCell in castArray {
                    self.castPropertiesDelegate?.name.append(perCell.name ?? "")
                    self.castPropertiesDelegate?.charName.append(perCell.character ?? "")
                    self.path.append(perCell.profile_path ?? "")
                    guard let personId = perCell.id else { return }
                    self.personIdArray.append("\(personId)")
                }
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }
    }
    
    // MARK: - Movie Detail
    public func movieDetail(with id: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        group.enter()
        configurationManager.fetchImages()
        detailClient.detailRequest(with: id) { (result) in
            defer { self.group.leave() }
            switch result {
            case .success(let detailData):
                defer { completion(.success(())); self.updater?() }
                guard let data = detailData else { return }
                guard let overview = data.overview else { return }
                guard let backdropPath = detailData?.backdrop_path else { return }
                self.backdropPath = backdropPath
                self.overview = overview
                self.releaseDate = data.release_date
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }
    }
    
    // MARK: - Video
    public func getVideos(with id: String, completion: @escaping(Result<Void, APIError>) -> Void) {
        group.enter()
        detailClient.detailRequest(with: id) { (result) in
            defer { self.group.leave() }
            switch result {
            case .success(let videoData):
                defer { completion(.success(())); self.updater?() }
                guard let data = videoData else { return }
                self.videos = data.videos.results.count
                for result in data.videos.results {
                    self.videoTitle.append(result.name)
                    self.videoId.append(result.id)
                    self.videoKey.append(result.key)
                    let stringySize = String(result.size)
                    self.videoSize.append(stringySize)
                    self.videoSite.append(result.site)
                }
            case .failure(_):
                completion(.failure(.requestFailed))
            }
        }
    }
    
    // TODO: Error here, "Server data incorrect. Please check back later and Try Again."
    public func requestThumbnailUrls(with key: String) {
        group.enter()
        thumbnailClient.requestThumbnailUrl(with: key) { (result) in
            defer { self.group.leave() }
            switch result {
            case .success(let thumbnailData):
                defer { self.updater?() }
                guard let data = thumbnailData else { return }
                for item in data.items {
                    self.thumbnailUrls.append(item.snippet.thumbnails.standard.url)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Removes saved data
    public func deleteAllSavedData() {
        path.removeAll()
        fullPath.removeAll()
        personIdArray.removeAll()
        videos = 0
        videoTitle.removeAll()
        videoId.removeAll()
        videoKey.removeAll()
        videoSite.removeAll()
        videoSize.removeAll()
        thumbnailUrls.removeAll()
    }
    
} // Class End
