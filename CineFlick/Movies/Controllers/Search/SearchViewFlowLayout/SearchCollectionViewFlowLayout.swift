//
//  SearchCollectionViewFlowLayout.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class SearchCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        scrollDirection = .vertical
        itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: 170)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension SearchCollectionViewFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: 170)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
