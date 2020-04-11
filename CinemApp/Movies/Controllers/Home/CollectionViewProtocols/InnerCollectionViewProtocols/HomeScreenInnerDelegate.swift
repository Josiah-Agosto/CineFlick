//
//  HomeScreenInnerDelegate.swift
//  CinemApp
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
            let cell = collectionView.cellForItem(at: indexPath) as! PopularMovieCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = cell.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = cell.backdropImage.image
            mainController.detailController.detailView.overview.text = cell.overview.text
            mainController.detailController.detailView.runtime.text = cell.runtime.text
            mainController.detailController.detailView.movieRating.text = cell.movieRating.text
            mainController.detailController.detailView.releaseDate.text = cell.releaseDate.text
            let id = mainController.apiManager.popularIds[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        case .nowPlaying:
            let cell2 = collectionView.cellForItem(at: indexPath) as! NowPlayingCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = cell2.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = cell2.backdropImage.image
            mainController.detailController.detailView.overview.text = cell2.overview.text
            mainController.detailController.detailView.runtime.text = cell2.runtime.text
            mainController.detailController.detailView.releaseDate.text = cell2.movieReleaseTitle.text
            let id = mainController.apiManager.nowPlayingIds[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        case .upcoming:
            let cell3 = collectionView.cellForItem(at: indexPath) as! UpcomingCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = cell3.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = cell3.backdropImage.image
            mainController.detailController.detailView.overview.text = cell3.overview.text
            mainController.detailController.detailView.runtime.text = cell3.runtime.text
            mainController.detailController.detailView.releaseDate.text = cell3.movieReleaseTitle.text
            let id = mainController.apiManager.upcomingIds[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        case .topRated:
            let cell4 = collectionView.cellForItem(at: indexPath) as! TopRatedCellsView
            group.enter()
            mainController.detailController.detailView.movieTitle.text = cell4.movieTitle.text
            mainController.detailController.detailView.backdropImage.image = cell4.backdropImage.image
            mainController.detailController.detailView.overview.text = cell4.overview.text
            mainController.detailController.detailView.runtime.text = cell4.runtime.text
            mainController.detailController.detailView.releaseDate.text = cell4.releaseDate.text
            let id = mainController.apiManager.topRatedIds[safe: indexPath.row] ?? ""
            group.leave()
            group.wait()
            group.notify(queue: .global()) {
                self.movieIdDelegate?.movieId = id
                self.selectedCellDelegate?.isCellSelected = true
                self.selectedCellDelegate?.isCellSelectedHandler()
            }
        }
    }
    
}
