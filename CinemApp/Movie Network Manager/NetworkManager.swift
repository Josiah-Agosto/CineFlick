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
    let dateReference = Date()
    // Popular Movie Variables
    var movieTitleAccomplice: [String] = []
    var movieFilmRatingAccomplice: [String] = []
    var movieImageURLAccomplice: [String] = []
    var movieImages: [UIImage] = []
    // Now Playing Variables
    var nowPlayingTitles: [String] = []
    var nowPlayingReleaseDates: [String] = []
    var nowPlayingImages: [UIImage] = []
    // Upcoming Variables
    var upcomingTitles: [String] = []
    var upcomingReleaseDates: [String] = []
    var upcomingImages: [UIImage] = []
    // Top Rated Variables
    var topRatedTitles: [String] = []
    var topRatedFilmRatings: [String] = []
    var topRatedImages: [UIImage] = []
    // References
    private var popularRequest: PopularProcess!
    private var nowPlayingRequest: NowPlayingProcess!
    private var upcomingRequest: UpcomingProcess!
    private var topRatedRequest: TopRatedProcess!
    private var movieCollectionView: MovieCollectionViewCell!
    private var homeScreen: HomeScreenController!
    
    
    public func makeApiCalls() {
        movieCollectionView = MovieCollectionViewCell()
        homeScreen = HomeScreenController()
        // Request's
        let group = DispatchGroup()
        let queue = OperationQueue()
        queue.addOperation {
            self.popularRequest = PopularProcess()
            // Cell 1
            group.enter()
            self.popularRequest.mainApiRequest(completionHandler: { (titles, filmRatings, _, error) in
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let filmRatings = filmRatings else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.movieTitleAccomplice.append(title)
                })
                filmRatings.forEach({ (filmRating) in
                    self.movieFilmRatingAccomplice.append(filmRating)
                })
                print("Doing Things")
            })
            group.leave()
            group.enter()
            self.popularRequest.filePathRequest(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("Thing 1")
            })
            group.leave()
            group.enter()
            self.popularRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("Thing 2")
            })
            group.leave()
            group.enter()
            self.popularRequest.makeUrlAnImage(completionHandler: { (images, error) in
                if let error = error { print(error) }
                guard let images = images else { print("Error, \(error.debugDescription)"); return }
                self.movieImages = images
                print("Finishing Things")
            })
            group.leave()
        // Cell 2
            self.nowPlayingRequest = NowPlayingProcess()
            group.enter()
            self.nowPlayingRequest.mainDataRequest(completionHandler: { (titles, releaseDate, error) in
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let releaseDate = releaseDate else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.nowPlayingTitles.append(title)
                })
                releaseDate.forEach({ (date) in
                    self.nowPlayingReleaseDates.append(self.dateReference.convertStringToDate(dateString: date))
                })
                print("hello")
            })
            group.leave()
            group.enter()
            self.nowPlayingRequest.filePathRequest(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("done 1")
            })
            group.leave()
            group.enter()
            self.nowPlayingRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("done 2")
            })
            group.leave()
            group.enter()
            self.nowPlayingRequest.makeUrlAnImage(completionHandler: { (images, error) in
                if let error = error { print(error) }
                guard let images = images else { print("Error, \(error.debugDescription)"); return }
                self.nowPlayingImages = images
                print("Images")
            })
            group.leave()
        // Cell 3
            self.upcomingRequest = UpcomingProcess()
            group.enter()
            self.upcomingRequest.mainDataRequest(completionHandler: { (titles, releaseDate, error) in
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let releaseDate = releaseDate else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.upcomingTitles.append(title)
                })
                releaseDate.forEach({ (date) in
                    self.upcomingReleaseDates.append(self.dateReference.convertStringToDate(dateString: date))
                })
                print("cell three")
            })
            group.leave()
            group.enter()
            self.upcomingRequest.filePathRequest(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("hello 1")
            })
            group.leave()
            group.enter()
            self.upcomingRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("working")
            })
            group.leave()
            group.enter()
            self.upcomingRequest.makeUrlAnImage(completionHandler: { (images, error) in
                if let error = error { print(error) }
                guard let images = images else { print("Error, \(error.debugDescription)"); return }
                self.upcomingImages = images
                print("Anything")
            })
            group.leave()
        // Cell 4
            self.topRatedRequest = TopRatedProcess()
            group.enter()
            self.topRatedRequest.mainApiRequest(completionHandler: { (titles, filmRatings, _, error) in
                if let error = error { print(error) }
                guard let titles = titles else { print("Error, \(error.debugDescription)"); return }
                guard let filmRatings = filmRatings else { print("Error, \(error.debugDescription)"); return }
                titles.forEach({ (title) in
                    self.topRatedTitles.append(title)
                })
                filmRatings.forEach({ (filmRating) in
                    self.topRatedFilmRatings.append(filmRating)
                })
                print("Got here")
            })
            group.leave()
            group.enter()
            self.topRatedRequest.filePathRequest(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("Ummm")
            })
            group.leave()
            group.enter()
            self.topRatedRequest.convertToUrl(completionHandler: { (_, error) in
                if let error = error { print(error) }
                print("here?")
            })
            group.leave()
            group.enter()
            self.topRatedRequest.makeUrlAnImage(completionHandler: { (images, error) in
                if let error = error { print(error) }
                guard let images = images else { print("Error, \(error.debugDescription)"); return }
                self.topRatedImages = images
                print("Images Yet")
            })
            group.leave()
            group.wait()
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
