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
        if movieEnum == .popular {
            return mainController.apiManager.popularTitles.count
        } else if movieEnum == .nowPlaying {
            return mainController.apiManager.nowPlayingTitles.count
        } else if movieEnum == .upcoming {
            return mainController.apiManager.upcomingTitles.count
        } else {
            return mainController.apiManager.topRatedTitles.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch movieEnum {
        case .popular:
            let popular = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCellsView.reuseIdentifier, for: indexPath) as! PopularMovieCellsView
            popular.movieTitle.text = mainController.apiManager.popularTitles[safe: indexPath.row]
            popular.movieRating.text = "\(mainController.apiManager.popularRatings[safe: indexPath.row] ?? "nil")%"
            popular.moviePosterImage.image = mainController.apiManager.popularImages[safe: indexPath.row]
            // For Detail View
            popular.backdropImage.image = mainController.apiManager.popularBackdropImages[safe: indexPath.row]
            popular.id.text = mainController.apiManager.popularIds[safe: indexPath.row]
            popular.overview.text = mainController.apiManager.popularOverview[safe: indexPath.row]
            popular.runtime.text = mainController.apiManager.popularRuntime[safe: indexPath.row]
            popular.releaseDate.text = mainController.apiManager.popularRelease[safe: indexPath.row]
            return popular
        case .nowPlaying:
            let nowPlaying = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCellsView.reuseIdentifier, for: indexPath) as! NowPlayingCellsView
            nowPlaying.movieTitle.text = mainController.apiManager.nowPlayingTitles[safe: indexPath.row]
            nowPlaying.movieReleaseTitle.text = mainController.apiManager.nowPlayingReleases[safe: indexPath.row]
            nowPlaying.movieImage.image = mainController.apiManager.nowPlayingImages[safe: indexPath.row]
            // For Detail View
            nowPlaying.backdropImage.image = mainController.apiManager.nowPlayingBackdropImages[safe: indexPath.row]
            nowPlaying.id.text = mainController.apiManager.nowPlayingIds[safe: indexPath.row]
            nowPlaying.overview.text = mainController.apiManager.nowPlayingOverview[safe: indexPath.row]
            nowPlaying.runtime.text = mainController.apiManager.nowPlayingRuntime[safe: indexPath.row]
            nowPlaying.rating.text = mainController.apiManager.nowPlayingRatings[safe: indexPath.row]
            return nowPlaying
        case .upcoming:
            let upcoming = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCellsView.reuseIdentifier, for: indexPath) as! UpcomingCellsView
            upcoming.movieTitle.text = mainController.apiManager.upcomingTitles[safe: indexPath.row]
            upcoming.movieReleaseTitle.text = mainController.apiManager.upcomingReleases[safe: indexPath.row]
            upcoming.movieImage.image = mainController.apiManager.upcomingImages[safe: indexPath.row]
            // For Detail View
            upcoming.backdropImage.image = mainController.apiManager.upcomingBackdropImages[safe: indexPath.row]
            upcoming.id.text = mainController.apiManager.upcomingIds[safe: indexPath.row]
            upcoming.overview.text = mainController.apiManager.upcomingOverview[safe: indexPath.row]
            upcoming.runtime.text = mainController.apiManager.upcomingRuntime[safe: indexPath.row]
            upcoming.rating.text = mainController.apiManager.upcomingRatings[safe: indexPath.row]
            return upcoming
        case .topRated:
            let topRated = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCellsView.reuseIdentifier, for: indexPath) as! TopRatedCellsView
            topRated.movieTitle.text = mainController.apiManager.topRatedTitles[safe: indexPath.row]
            topRated.movieRating.text = mainController.apiManager.topRatedReleases[safe: indexPath.row]
            topRated.movieImage.image = mainController.apiManager.topRatedImages[safe: indexPath.row]
            // For Detail View
            topRated.backdropImage.image = mainController.apiManager.topRatedBackdropImages[safe: indexPath.row]
            topRated.id.text = mainController.apiManager.topRatedIds[safe: indexPath.row]
            topRated.overview.text = mainController.apiManager.topRatedOverview[safe: indexPath.row]
            topRated.runtime.text = mainController.apiManager.topRatedRuntime[safe: indexPath.row]
            topRated.rating.text = mainController.apiManager.topRatedRatings[safe: indexPath.row]
            topRated.releaseDate.text = mainController.apiManager.topRatedReleases[safe: indexPath.row]
            return topRated
        }
    }
    
}
