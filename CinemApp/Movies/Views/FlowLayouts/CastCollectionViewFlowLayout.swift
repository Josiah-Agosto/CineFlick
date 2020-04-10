//
//  CastCollectionViewFlowLayout.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class CastCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumLineSpacing = 8
        self.minimumInteritemSpacing = 0
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: 125, height: 180)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
