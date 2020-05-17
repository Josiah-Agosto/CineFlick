//
//  CastCollectionViewDelegate.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class CastCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    private var detailController: DetailViewController
    
    init(detailController: DetailViewController) {
        self.detailController = detailController
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let castCell = collectionView.cellForItem(at: indexPath) as? CastCollectionViewCell {
            print("Cast Selected")
            detailController.detailView.personSelectedDelegate?.hasSelectedCell()
            let id = detailController.detailManager.personIdArray[safe: indexPath.row] ?? ""
            detailController.detailView.personSelectedIdDelegate?.personId = id
            detailController.personController.personView.personName.text = castCell.name.text
            detailController.personController.personView.profilePicture.image = castCell.person.image
        }
    }
    
}
