//
//  VideoCollectionViewFlowLayout.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/5/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class VideoCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumLineSpacing = 16
        self.minimumInteritemSpacing = 16
        self.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 225)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
