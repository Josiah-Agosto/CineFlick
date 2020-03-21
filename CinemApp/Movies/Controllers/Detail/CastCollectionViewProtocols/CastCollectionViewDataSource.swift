//
//  CastCollectionViewDataSource.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class CastCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var castCountForSection: Int = 0
    var name: [String] = []
    var charName: [String] = []
    var profileImage: [UIImage] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castCountForSection
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CastCollectionViewCell
        cell.name.text = name[safe: indexPath.row] ?? ""
        cell.characterName.text = charName[safe: indexPath.row] ?? ""
        cell.person.image = profileImage[safe: indexPath.row] ?? UIImage(named: "ImageNotFound")
        return cell
    }
}
