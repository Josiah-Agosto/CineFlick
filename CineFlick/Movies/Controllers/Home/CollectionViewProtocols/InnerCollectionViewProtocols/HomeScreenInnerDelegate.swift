//
//  HomeScreenInnerDelegate.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension MovieCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch movieEnum {
        case .popular:
            let popularRow = collectionView.cellForItem(at: indexPath) as! PopularMovieCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = popularRow.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = popularRow.backdropImage.image
            mainController.detailController.detailView.overview.text = popularRow.overview.text
            mainController.detailController.detailView.runtime.text = popularRow.runtime.text
            mainController.detailController.detailView.movieRating.text = popularRow.movieRating.text
            mainController.detailController.detailView.releaseDate.text = popularRow.releaseDate.text
            let id = mainController.apiManager.popularIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.popularTitles[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.movieIdDelegate?.movieName = movieTitle
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        case .nowPlaying:
            let nowPlayingRow = collectionView.cellForItem(at: indexPath) as! NowPlayingCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = nowPlayingRow.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = nowPlayingRow.backdropImage.image
            mainController.detailController.detailView.overview.text = nowPlayingRow.overview.text
            mainController.detailController.detailView.runtime.text = nowPlayingRow.runtime.text
            mainController.detailController.detailView.releaseDate.text = nowPlayingRow.movieReleaseTitle.text
            let id = mainController.apiManager.nowPlayingIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.nowPlayingTitles[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.movieIdDelegate?.movieName = movieTitle
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        case .upcoming:
            let upcomingRow = collectionView.cellForItem(at: indexPath) as! UpcomingCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = upcomingRow.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = upcomingRow.backdropImage.image
            mainController.detailController.detailView.overview.text = upcomingRow.overview.text
            mainController.detailController.detailView.runtime.text = upcomingRow.runtime.text
            mainController.detailController.detailView.releaseDate.text = upcomingRow.movieReleaseTitle.text
            let id = mainController.apiManager.upcomingIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.upcomingTitles[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.movieIdDelegate?.movieName = movieTitle
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        case .topRated:
            let topRatedRow = collectionView.cellForItem(at: indexPath) as! TopRatedCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = topRatedRow.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = topRatedRow.backdropImage.image
            mainController.detailController.detailView.overview.text = topRatedRow.overview.text
            mainController.detailController.detailView.runtime.text = topRatedRow.runtime.text
            mainController.detailController.detailView.releaseDate.text = topRatedRow.releaseDate.text
            let id = mainController.apiManager.topRatedIds[safe: indexPath.row] ?? ""
            let movieTitle = mainController.apiManager.topRatedTitles[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.movieIdDelegate?.movieName = movieTitle
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        }
    }
    
}
