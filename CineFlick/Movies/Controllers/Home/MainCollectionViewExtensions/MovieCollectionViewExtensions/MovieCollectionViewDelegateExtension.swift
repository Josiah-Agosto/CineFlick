//
//  HomeScreenInnerDelegate.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var parentCell: MovieCollectionViewCell
    var mainController: HomeScreenController
    
    init(mainController: HomeScreenController, parentCell: MovieCollectionViewCell) {
        self.mainController = mainController
        self.parentCell = parentCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch parentCell.cellSelection {
        case .popular:
            let popularRow = collectionView.cellForItem(at: indexPath) as! PopularMovieCellsView
            let id = mainController.apiManager.popularIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.popularTitles[safe: indexPath.row] ?? ""
            let popularBackdropUrl = mainController.apiManager.popularBackdropURLs[safe: indexPath.row] ?? ""
            // Delegates
            parentCell.movieIdDelegate?.movieId = id
            parentCell.movieIdDelegate?.movieName = movieTitle
            parentCell.movieIdDelegate?.selectedBackdropUrl = popularBackdropUrl
            // Detail View
            mainController.detailController?.detailView.movieTitle.text = popularRow.movieTitle.text
            mainController.detailController?.detailView.overview.text = popularRow.overview.text
            mainController.detailController?.detailView.movieRating.text = popularRow.movieRating.text
            mainController.detailController?.detailView.releaseDate.text = popularRow.releaseDate.text
            // Delegate Properties
            cellHasBeenSelected()
        case .nowPlaying:
            let nowPlayingRow = collectionView.cellForItem(at: indexPath) as! NowPlayingCellsView
            let id = mainController.apiManager.nowPlayingIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.nowPlayingTitles[safe: indexPath.row] ?? ""
            let nowPlayingBackdropUrl = mainController.apiManager.nowPlayingBackdropURLs[safe: indexPath.row] ?? ""
            // Delegates
            parentCell.movieIdDelegate?.movieId = id
            parentCell.movieIdDelegate?.movieName = movieTitle
            parentCell.movieIdDelegate?.selectedBackdropUrl = nowPlayingBackdropUrl
            // Detail View
            let rating = mainController.apiManager.nowPlayingRatings[safe: indexPath.row] ?? ""
            mainController.detailController?.detailView.movieTitle.text = nowPlayingRow.movieTitle.text
            mainController.detailController?.detailView.overview.text = nowPlayingRow.overview.text
            mainController.detailController?.detailView.releaseDate.text = nowPlayingRow.movieReleaseTitle.text
            mainController.detailController?.detailView.movieRating.text = "\(rating)%"
            // Delegate Properties
            cellHasBeenSelected()
        case .upcoming:
            let upcomingRow = collectionView.cellForItem(at: indexPath) as! UpcomingCellsView
            let id = mainController.apiManager.upcomingIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.upcomingTitles[safe: indexPath.row] ?? ""
            let upcomingBackdropUrl = mainController.apiManager.upcomingBackdropURLs[safe: indexPath.row] ?? ""
            // Delegates
            parentCell.movieIdDelegate?.movieId = id
            parentCell.movieIdDelegate?.movieName = movieTitle
            parentCell.movieIdDelegate?.selectedBackdropUrl = upcomingBackdropUrl
            // Detail View
            let rating = mainController.apiManager.upcomingRatings[safe: indexPath.row] ?? ""
            mainController.detailController?.detailView.movieTitle.text = upcomingRow.movieTitle.text
            mainController.detailController?.detailView.overview.text = upcomingRow.overview.text
            mainController.detailController?.detailView.releaseDate.text = upcomingRow.movieReleaseTitle.text
            mainController.detailController?.detailView.movieRating.text = "\(rating)%"
            // Delegate Properties
            cellHasBeenSelected()
        case .topRated:
            let topRatedRow = collectionView.cellForItem(at: indexPath) as! TopRatedCellsView
            let id = mainController.apiManager.topRatedIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.topRatedTitles[safe: indexPath.row] ?? ""
            let topRatedBackdropUrl = mainController.apiManager.topRatedBackdropURLs[safe: indexPath.row] ?? ""
            // Assigning Delegates
            parentCell.movieIdDelegate?.movieId = id
            parentCell.movieIdDelegate?.movieName = movieTitle
            parentCell.movieIdDelegate?.selectedBackdropUrl = topRatedBackdropUrl
            // Detail View
            let rating = mainController.apiManager.topRatedRatings[safe: indexPath.row] ?? ""
            mainController.detailController?.detailView.movieTitle.text = topRatedRow.movieTitle.text
            mainController.detailController?.detailView.overview.text = topRatedRow.overview.text
            mainController.detailController?.detailView.releaseDate.text = topRatedRow.releaseDate.text
            mainController.detailController?.detailView.movieRating.text = "\(rating)%"
            // Delegate Properties
            cellHasBeenSelected()
        }
    } // Did Select End
    
    
    private func cellHasBeenSelected() {
        parentCell.selectedCellDelegate?.isCellSelected = true
        parentCell.selectedCellDelegate?.isCellSelectedHandler()
    }
    
}
