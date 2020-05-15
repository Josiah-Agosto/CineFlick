//
//  VideoCollectionViewFlowLayout.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/5/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class VideoCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var previousOffset: CGFloat = 0
    private var currentPage: Int = 0
    
    override init() {
        super.init()
        self.minimumLineSpacing = 16
        self.minimumInteritemSpacing = 16
        self.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 225)
    }
    
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
            currentPage = max(currentPage - 1, 0)
        } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
            currentPage = min(currentPage + 1, itemsCount - 1)
        }
        let currentlyDisplayedOffset = (itemSize.width + minimumInteritemSpacing) * CGFloat(currentPage)
        previousOffset = currentlyDisplayedOffset
        return CGPoint(x: currentlyDisplayedOffset, y: proposedContentOffset.y)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
