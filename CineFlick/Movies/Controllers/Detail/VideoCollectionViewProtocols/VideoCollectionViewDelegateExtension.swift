//
//  VideoCollectionViewDelegate.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/6/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class VideoCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var detailController: DetailViewController
    
    init(detailController: DetailViewController) {
        self.detailController = detailController
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let videoCell = collectionView.cellForItem(at: indexPath) as? VideoCollectionViewCell {
            videoCell.selectedVideoDelegate = detailController
            let key = videoCell.videoKey
            videoCell.selectedVideoDelegate?.selectedVideo(key, videoCell)
        }
    }
}
