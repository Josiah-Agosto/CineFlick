//
//  Data.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    // Popular Movie Variables
    var popularTitles: [String] = [] { didSet { updatingModel?() } }
    var popularFilmRating: [String] = [] { didSet { updatingModel?() } }
    var popularImageUrl: [String] = [] { didSet { updatingModel?() } }
    var popularImages: [UIImage] = [] { didSet { updatingModel?() } }
    // Now Playing Variables
    var nowPlayingTitles: [String] = [] { didSet { updatingModel?() } }
    var nowPlayingReleaseDates: [String] = [] { didSet { updatingModel?() } }
    var nowPlayingImages: [UIImage] = [] { didSet { updatingModel?() } }
    // Upcoming Variables
    var upcomingTitles: [String] = [] { didSet { updatingModel?() } }
    var upcomingReleaseDates: [String] = [] { didSet { updatingModel?() } }
    var upcomingImages: [UIImage] = [] { didSet { updatingModel?() } }
    // Top Rated Variables
    var topRatedTitles: [String] = [] { didSet { updatingModel?() } }
    var topRatedFilmRatings: [String] = [] { didSet { updatingModel?() } }
    var topRatedImages: [UIImage] = [] { didSet { updatingModel?() } }
    // References
    private var popularRequest: PopularProcess!
    private var nowPlayingRequest: NowPlayingProcess!
    private var upcomingRequest: UpcomingProcess!
    private var topRatedRequest: TopRatedProcess!
    private let dateReference = Date()
    var updatingModel: (()->())? = nil
    
    
    public func makeApiCalls(completion: @escaping () -> Void) -> Void {
        // Request's
        let group = DispatchGroup()
        let queue = OperationQueue()
        queue.addOperation {
            self.popularRequest = PopularProcess()
            // Cell 1
            group.enter()
            self.popularRequest.mainApiRequest(completionHandler: { (titles, filmRatings, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let filmRatings = filmRatings else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.popularTitles.append(title)
                })
                filmRatings.forEach({ (filmRating) in
                    self.popularFilmRating.append(filmRating)
                })
            })
            group.enter()
            self.popularRequest.filePathRequest(completionHandler: { (_, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
            })
            group.wait()
            group.enter()
            self.popularRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                self.popularRequest.makeUrlAnImage(completionHandler: { (images, error) in
                    if let error = error { print(error) }
                    guard let images = images else { print("Error, \(error.debugDescription)"); return }
                    self.popularImages = images
                })
                group.leave()
            })
            group.wait()
        // Cell 2
            self.nowPlayingRequest = NowPlayingProcess()
            group.enter()
            self.nowPlayingRequest.mainDataRequest(completionHandler: { (titles, releaseDate, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let releaseDate = releaseDate else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.nowPlayingTitles.append(title)
                })
                releaseDate.forEach({ (date) in
                    self.nowPlayingReleaseDates.append(self.dateReference.convertStringToDate(dateString: date))
                })
            })
            group.enter()
            self.nowPlayingRequest.filePathRequest(completionHandler: { (_, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
            })
            group.wait()
            group.enter()
            self.nowPlayingRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                self.nowPlayingRequest.makeUrlAnImage(completionHandler: { (images, error) in
                    if let error = error { print(error) }
                    guard let images = images else { print("Error, \(error.debugDescription)"); return }
                    self.nowPlayingImages = images
                })
                group.leave()
            })
            group.wait()
        // Cell 3
            self.upcomingRequest = UpcomingProcess()
            group.enter()
            self.upcomingRequest.mainDataRequest(completionHandler: { (titles, releaseDate, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let releaseDate = releaseDate else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.upcomingTitles.append(title)
                })
                releaseDate.forEach({ (date) in
                    self.upcomingReleaseDates.append(self.dateReference.convertStringToDate(dateString: date))
                })
            })
            group.enter()
            self.upcomingRequest.filePathRequest(completionHandler: { (_, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
            })
            group.wait()
            group.enter()
            self.upcomingRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                self.upcomingRequest.makeUrlAnImage(completionHandler: { (images, error) in
                    if let error = error { print(error) }
                    guard let images = images else { print("Error, \(error.debugDescription)"); return }
                    self.upcomingImages = images
                })
                group.leave()
            })
            group.wait()
        // Cell 4
            self.topRatedRequest = TopRatedProcess()
            group.enter()
            self.topRatedRequest.mainApiRequest(completionHandler: { (titles, filmRatings, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let filmRatings = filmRatings else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.topRatedTitles.append(title)
                })
                filmRatings.forEach({ (filmRating) in
                    self.topRatedFilmRatings.append(filmRating)
                })
            })
            group.enter()
            self.topRatedRequest.filePathRequest(completionHandler: { (_, error) in
                defer {
                    group.leave()
                }
                if let error = error { print(error) }
            })
            group.wait()
            group.enter()
            self.topRatedRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                self.topRatedRequest.makeUrlAnImage(completionHandler: { (images, error) in
                    if let error = error { print(error) }
                    guard let images = images else { print("Error, \(error.debugDescription)"); return }
                    self.topRatedImages = images
                })
                group.leave()
            })
            group.notify(queue: DispatchQueue.main, execute: {
                completion()
                self.updatingModel?()
            })
        }
    }
    
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
