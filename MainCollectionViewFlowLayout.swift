//
//  MovieCollectionViewFlowLayout.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/14/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class MainCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumLineSpacing = 5
        self.minimumInteritemSpacing = 5
        self.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.scrollDirection = .vertical
        self.itemSize = CGSize(width: 125, height: 200)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
