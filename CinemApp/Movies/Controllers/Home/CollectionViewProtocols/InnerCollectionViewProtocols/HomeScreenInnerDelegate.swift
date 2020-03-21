//
//  HomeScreenInnerDelegate.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenInnerDelegate: NSObject, UICollectionViewDelegate {
    private var parent: MovieCollectionViewCell!
    weak var selectedCellDelegate: InnerCellPropertyProtocol?
    private let group = DispatchGroup()
    
    init(parentCell: MovieCollectionViewCell, withDelegate: InnerCellPropertyProtocol) {
        self.parent = parentCell
        self.selectedCellDelegate = withDelegate
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 200)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch parent.movieEnum {
            case .popular:
                let cell = collectionView.cellForItem(at: indexPath) as! PopularMovieCellsView
                parent.mainController.detailController.detailView.movieTitle.text = cell.movieTitle.text
                parent.mainController.detailController.detailView.backdropImage.image = cell.backdropImage.image
                parent.mainController.detailController.detailView.overview.text = cell.overview.text
                parent.mainController.detailController.detailView.runtime.text = cell.runtime.text
                parent.mainController.detailController.detailView.movieRating.text = cell.movieRating.text
                parent.mainController.detailController.detailView.releaseDate.text = cell.releaseDate.text
                let id = parent.mainController.apiManager.popularIds[safe: indexPath.row] ?? ""
                selectedCellDelegate?.movieId = id
                selectedCellDelegate?.selectedCell(isSelected: true)
                print("Popular")
                break
            case .nowPlaying:
                let cell2 = collectionView.cellForItem(at: indexPath) as! NowPlayingCellsView
                parent.mainController.detailController.detailView.movieTitle.text = cell2.movieTitle.text
                parent.mainController.detailController.detailView.backdropImage.image = cell2.backdropImage.image
                parent.mainController.detailController.detailView.overview.text = cell2.overview.text
                parent.mainController.detailController.detailView.runtime.text = cell2.runtime.text
                parent.mainController.detailController.detailView.releaseDate.text = cell2.movieReleaseTitle.text
                let id = parent.mainController.apiManager.nowPlayingIds[safe: indexPath.row] ?? ""
                // Showing it to Detail
                group.enter()
                selectedCellDelegate?.movieId = id
                selectedCellDelegate?.selectedCell(isSelected: true)
                group.leave()
                group.notify(queue: DispatchQueue.main) {
                    self.parent.mainController.detailController.detailView.castCollectionView.reloadData()
                }
                print("Now Playing")
                break
            case .upcoming:
                let cell3 = collectionView.cellForItem(at: indexPath) as! UpcomingCellsView
                parent.mainController.detailController.detailView.movieTitle.text = cell3.movieTitle.text
                parent.mainController.detailController.detailView.backdropImage.image = cell3.backdropImage.image
                parent.mainController.detailController.detailView.overview.text = cell3.overview.text
                parent.mainController.detailController.detailView.runtime.text = cell3.runtime.text
                parent.mainController.detailController.detailView.releaseDate.text = cell3.movieReleaseTitle.text
                let id = parent.mainController.apiManager.upcomingIds[safe: indexPath.row] ?? ""
                // Showing it to Detail
                group.enter()
                selectedCellDelegate?.movieId = id
                selectedCellDelegate?.selectedCell(isSelected: true)
                group.leave()
                group.notify(queue: DispatchQueue.main) {
                    self.parent.mainController.detailController.detailView.castCollectionView.reloadData()
                }
                print("Upcoming")
                break
            case .topRated:
                let cell4 = collectionView.cellForItem(at: indexPath) as! TopRatedCellsView
                parent.mainController.detailController.detailView.movieTitle.text = cell4.movieTitle.text
                parent.mainController.detailController.detailView.backdropImage.image = cell4.backdropImage.image
                parent.mainController.detailController.detailView.overview.text = cell4.overview.text
                parent.mainController.detailController.detailView.runtime.text = cell4.runtime.text
                parent.mainController.detailController.detailView.releaseDate.text = cell4.releaseDate.text
                let id = parent.mainController.apiManager.topRatedIds[safe: indexPath.row] ?? ""
                // Showing it to Detail
                group.enter()
                selectedCellDelegate?.movieId = id
                selectedCellDelegate?.selectedCell(isSelected: true)
                group.leave()
                group.notify(queue: DispatchQueue.main) {
                    self.parent.mainController.detailController.detailView.castCollectionView.reloadData()
                }
                print("Top Rated")
                break
            }
        }
}
