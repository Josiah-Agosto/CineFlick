//
//  SearchCollectionViewFlowLayout.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

// Hint: Move the item size to datasource and use sizeForItemAt instead
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
}
