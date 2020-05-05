//
//  SearchCollectionViewDataSourceExtension.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchManager.movieIds.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSearchCell.reuseIdentifier, for: indexPath) as! MovieSearchCell
        let id = searchManager.movieIds[safe: indexPath.row] ?? ""
        searchCell.cellId = id
        searchCell.movieTitle.text = searchManager.movieTitles[safe: indexPath.row]
        let imageUrlForIndexPath = searchManager.movieImageUrls[safe: indexPath.row] ?? ""
        searchCell.movieImageView.asynchronouslyLoadImage(with: imageUrlForIndexPath)
        return searchCell
    }
    
}
