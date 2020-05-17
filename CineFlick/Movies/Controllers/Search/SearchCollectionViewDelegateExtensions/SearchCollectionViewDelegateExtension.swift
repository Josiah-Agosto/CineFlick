//
//  SearchCollectionViewDelegateExtension.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension SearchView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.05, options: .curveLinear, animations: {
            cell.alpha = 1
        }, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = collectionView.cellForItem(at: indexPath) as? MovieSearchCell {
            let id = searchController.searchManager.movieIds[safe: indexPath.row] ?? ""
            let title = searchController.searchManager.movieTitles[safe: indexPath.row]
            searchController.searchDetailController.searchDetailView.movieTitle.text = title
            searchMovieIdDelegate?.movieId = id
            movieSelectedDelegate?.didSelectMovie()
        }
    }
}
