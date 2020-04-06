//
//  HomeScreenInnerDataSource.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenInnerDataSource: NSObject, UICollectionViewDataSource {
    private var parent: MovieCollectionViewCell!
    
    init(parentCell: MovieCollectionViewCell) {
        self.parent = parentCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if parent.movieEnum == .popular {
            return parent.mainController.apiManager.popularTitles.count
        } else if parent.movieEnum == .nowPlaying {
            return parent.mainController.apiManager.nowPlayingTitles.count
        } else if parent.movieEnum == .upcoming {
            return parent.mainController.apiManager.upcomingTitles.count
        } else {
            return parent.mainController.apiManager.topRatedTitles.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch parent.movieEnum {
        case .popular:
            let popular = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCellsView.reuseIdentifier, for: indexPath) as! PopularMovieCellsView
            popular.movieTitle.text = parent.mainController.apiManager.popularTitles[safe: indexPath.row]
            popular.movieRating.text = "\(parent.mainController.apiManager.popularRatings[safe: indexPath.row] ?? "nil") %"
            popular.moviePosterImage.image = parent.mainController.apiManager.popularImages[safe: indexPath.row]
            // For Detail View
            popular.backdropImage.image = parent.mainController.apiManager.popularBackdropImages[safe: indexPath.row]
            popular.id.text = parent.mainController.apiManager.popularIds[safe: indexPath.row]
            popular.overview.text = parent.mainController.apiManager.popularOverview[safe: indexPath.row]
            popular.runtime.text = parent.mainController.apiManager.popularRuntime[safe: indexPath.row]
            popular.releaseDate.text = parent.mainController.apiManager.popularRelease[safe: indexPath.row]
            return popular
        case .nowPlaying:
            let nowPlaying = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCellsView.reuseIdentifier, for: indexPath) as! NowPlayingCellsView
            nowPlaying.movieTitle.text = parent.mainController.apiManager.nowPlayingTitles[safe: indexPath.row]
            nowPlaying.movieReleaseTitle.text = parent.mainController.apiManager.nowPlayingReleases[safe: indexPath.row]
            nowPlaying.movieImage.image = parent.mainController.apiManager.nowPlayingImages[safe: indexPath.row]
            // For Detail View
            nowPlaying.backdropImage.image = parent.mainController.apiManager.nowPlayingBackdropImages[safe: indexPath.row]
            nowPlaying.id.text = parent.mainController.apiManager.nowPlayingIds[safe: indexPath.row]
            nowPlaying.overview.text = parent.mainController.apiManager.nowPlayingOverview[safe: indexPath.row]
            nowPlaying.runtime.text = parent.mainController.apiManager.nowPlayingRuntime[safe: indexPath.row]
            nowPlaying.rating.text = parent.mainController.apiManager.nowPlayingRatings[safe: indexPath.row]
            return nowPlaying
        case .upcoming:
            let upcoming = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCellsView.reuseIdentifier, for: indexPath) as! UpcomingCellsView
            upcoming.movieTitle.text = parent.mainController.apiManager.upcomingTitles[safe: indexPath.row]
            upcoming.movieReleaseTitle.text = parent.mainController.apiManager.upcomingReleases[safe: indexPath.row]
            upcoming.movieImage.image = parent.mainController.apiManager.upcomingImages[safe: indexPath.row]
            // For Detail View
            upcoming.backdropImage.image = parent.mainController.apiManager.upcomingBackdropImages[safe: indexPath.row]
            upcoming.id.text = parent.mainController.apiManager.upcomingIds[safe: indexPath.row]
            upcoming.overview.text = parent.mainController.apiManager.upcomingOverview[safe: indexPath.row]
            upcoming.runtime.text = parent.mainController.apiManager.upcomingRuntime[safe: indexPath.row]
            upcoming.rating.text = parent.mainController.apiManager.upcomingRatings[safe: indexPath.row]
            return upcoming
        case .topRated:
            let topRated = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCellsView.reuseIdentifier, for: indexPath) as! TopRatedCellsView
            topRated.movieTitle.text = parent.mainController.apiManager.topRatedTitles[safe: indexPath.row]
            topRated.movieRating.text = parent.mainController.apiManager.topRatedReleases[safe: indexPath.row]
            topRated.movieImage.image = parent.mainController.apiManager.topRatedImages[safe: indexPath.row]
            // For Detail View
            topRated.backdropImage.image = parent.mainController.apiManager.topRatedBackdropImages[safe: indexPath.row]
            topRated.id.text = parent.mainController.apiManager.topRatedIds[safe: indexPath.row]
            topRated.overview.text = parent.mainController.apiManager.topRatedOverview[safe: indexPath.row]
            topRated.runtime.text = parent.mainController.apiManager.topRatedRuntime[safe: indexPath.row]
            topRated.rating.text = parent.mainController.apiManager.topRatedRatings[safe: indexPath.row]
            topRated.releaseDate.text = parent.mainController.apiManager.topRatedReleases[safe: indexPath.row]
            return topRated
        }
    }
}
