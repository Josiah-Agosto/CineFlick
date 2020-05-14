//
//  CastCollectionViewDataSource.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class CastCollectionViewDataSource: NSObject, UICollectionViewDataSource, CastDataSourceProtocol {
    // Properties
    private(set) var detailController: DetailViewController
    // Cast Data Source Properties
    var castCountForSection: Int = 0
    var name: [String] = []
    var charName: [String] = []
    
    init(detailController: DetailViewController) {
        self.detailController = detailController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castCountForSection
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.reuseIdentifier, for: indexPath) as! CastCollectionViewCell
        cell.name.text = name[safe: indexPath.row] ?? "Not Found"
        cell.characterName.text = charName[safe: indexPath.row] ?? "Not Found"
        let personImages = detailController.detailManager.fullPath[safe: indexPath.row] ?? ""
        cell.person.asynchronouslyLoadImage(with: personImages)
        return cell
    }

}
