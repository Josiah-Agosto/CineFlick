//
//  HomeScreenDelegate.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class HomeScreenDelegate: NSObject, UICollectionViewDelegate, HomeScreenPropertiesProtocol {
    var mainController: HomeScreenController!

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainController.mainView.collectionView.bounds.width - 10, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: mainController.mainView.frame.width, height: 40)
    }
}
