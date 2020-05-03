//
//  MovieCollectionViewCell Extension
//  CineFlick
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension MovieCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellSelection == .popular {
            return mainController.apiManager.popularTitles.count
        } else if cellSelection == .nowPlaying {
            return mainController.apiManager.nowPlayingTitles.count
        } else if cellSelection == .upcoming {
            return mainController.apiManager.upcomingTitles.count
        } else {
            return mainController.apiManager.topRatedTitles.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellSelection {
        case .popular:
            let popular = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCellsView.reuseIdentifier, for: indexPath) as! PopularMovieCellsView
            popular.movieTitle.text = mainController.apiManager.popularTitles[safe: indexPath.row]
            popular.movieRating.text = "\(mainController.apiManager.popularRatings[safe: indexPath.row] ?? "nil")%"
            let popularUrlForIndexPath = mainController.apiManager.popularImagesURLs[safe: indexPath.row] ?? ""
            popular.moviePosterImage.asynchronouslyLoadImage(with: popularUrlForIndexPath)
            // For Detail View
            popular.backdropImage.image = mainController.apiManager.popularBackdropImages[safe: indexPath.row]
            popular.id.text = mainController.apiManager.popularIds[safe: indexPath.row]
            popular.overview.text = mainController.apiManager.popularOverview[safe: indexPath.row]
            popular.releaseDate.text = mainController.apiManager.popularRelease[safe: indexPath.row]
            return popular
        case .nowPlaying:
            let nowPlaying = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCellsView.reuseIdentifier, for: indexPath) as! NowPlayingCellsView
            nowPlaying.movieTitle.text = mainController.apiManager.nowPlayingTitles[safe: indexPath.row]
            nowPlaying.movieReleaseTitle.text = mainController.apiManager.nowPlayingReleases[safe: indexPath.row]
            let nowPlayingUrlForIndexPath = mainController.apiManager.nowPlayingImagesURLs[safe: indexPath.row] ?? ""
            nowPlaying.movieImage.asynchronouslyLoadImage(with: nowPlayingUrlForIndexPath)
            // For Detail View
            nowPlaying.backdropImage.image = mainController.apiManager.nowPlayingBackdropImages[safe: indexPath.row]
            nowPlaying.id.text = mainController.apiManager.nowPlayingIds[safe: indexPath.row]
            nowPlaying.overview.text = mainController.apiManager.nowPlayingOverview[safe: indexPath.row]
            nowPlaying.rating.text = "\(mainController.apiManager.nowPlayingRatings[safe: indexPath.row] ?? "nil")%"
            return nowPlaying
        case .upcoming:
            let upcoming = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCellsView.reuseIdentifier, for: indexPath) as! UpcomingCellsView
            upcoming.movieTitle.text = mainController.apiManager.upcomingTitles[safe: indexPath.row]
            upcoming.movieReleaseTitle.text = mainController.apiManager.upcomingReleases[safe: indexPath.row]
            let upcomingUrlForIndexPath = mainController.apiManager.upcomingImagesURLs[safe: indexPath.row] ?? ""
            upcoming.movieImage.asynchronouslyLoadImage(with: upcomingUrlForIndexPath)
            // For Detail View
            upcoming.backdropImage.image = mainController.apiManager.upcomingBackdropImages[safe: indexPath.row]
            upcoming.id.text = mainController.apiManager.upcomingIds[safe: indexPath.row]
            upcoming.overview.text = mainController.apiManager.upcomingOverview[safe: indexPath.row]
            upcoming.rating.text = "\(mainController.apiManager.upcomingRatings[safe: indexPath.row] ?? "nil")%"
            return upcoming
        case .topRated:
            let topRated = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCellsView.reuseIdentifier, for: indexPath) as! TopRatedCellsView
            topRated.movieTitle.text = mainController.apiManager.topRatedTitles[safe: indexPath.row]
            topRated.movieRating.text = mainController.apiManager.topRatedReleases[safe: indexPath.row]
            let topRatedUrlForIndexPath = mainController.apiManager.topRatedImagesURLs[safe: indexPath.row] ?? ""
            topRated.movieImage.asynchronouslyLoadImage(with: topRatedUrlForIndexPath)
            // For Detail View
            topRated.backdropImage.image = mainController.apiManager.topRatedBackdropImages[safe: indexPath.row]
            topRated.id.text = mainController.apiManager.topRatedIds[safe: indexPath.row]
            topRated.overview.text = mainController.apiManager.topRatedOverview[safe: indexPath.row]
            topRated.rating.text = "\(mainController.apiManager.topRatedRatings[safe: indexPath.row] ?? "nil")%"
            topRated.releaseDate.text = mainController.apiManager.topRatedReleases[safe: indexPath.row]
            return topRated
        }
    }
    
}
