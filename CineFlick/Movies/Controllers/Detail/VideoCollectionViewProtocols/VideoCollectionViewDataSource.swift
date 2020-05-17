//
//  VideoCollectionViewDataSource.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/6/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class VideoCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private var detailController: DetailViewController
    
    init(detailController: DetailViewController) {
        self.detailController = detailController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailController.detailManager.videos
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        videoCell.videoTitle.text = detailController.detailManager.videoTitle[safe: indexPath.row] ?? "Trailer"
        videoCell.videoKey = detailController.detailManager.videoKey[safe: indexPath.row] ?? ""
        let videoUrl = detailController.detailManager.thumbnailUrls[safe: indexPath.row] ?? ""
        videoCell.videoThumbnailView.asynchronouslyLoadImage(with: videoUrl)
        return videoCell
    }
    
}
