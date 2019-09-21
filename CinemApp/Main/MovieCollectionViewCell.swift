//
//  MovieCollectionViewCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/14/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    // Date Formatter
    private let dateFormatter = DateFormatter()
    // Inner Cell
    let innerCollectionView: UICollectionView = {
        let layout = InnerCollectionViewFlowLayout()
        // Inner Collection View NOT Cell
        let initializingCollectionView = UICollectionView(frame: CGRect(x: 5, y: 0, width: UIScreen.main.bounds.width - 10, height: 300), collectionViewLayout: layout)
        initializingCollectionView.backgroundColor = UIColor.clear
        return initializingCollectionView
    }()
    // Movie Enum
    var movieEnum: MovieSectionEnum = .popular
    // Reference to API Manager
    var apiManager: APINetworkManager!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        innerCollectionView.delegate = self
        innerCollectionView.dataSource = self
        innerCollectionView.showsHorizontalScrollIndicator = false
        innerCollectionView.allowsSelection = true
        innerCollectionView.register(PopularMovieCellsCell.self, forCellWithReuseIdentifier: "popularCellsCell")
        innerCollectionView.register(NowPlayingCellsCell.self, forCellWithReuseIdentifier: "nowPlayingCellsCell")
        innerCollectionView.register(UpcomingCellsCell.self, forCellWithReuseIdentifier: "upcomingCellsCell")
        innerCollectionView.register(TopRatedCellsCell.self, forCellWithReuseIdentifier: "topRatedCellsCell")
        addSubview(innerCollectionView)
        // Worked On July 21, Sunday 12:06
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Initial Collection View Cell
        self.frame.size.width = UIScreen.main.bounds.width
        self.frame.size.height = 300
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
} // Class End


// Movie Cell Data Source
extension MovieCollectionViewCell: UICollectionViewDataSource {
    // Number of each cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieEnum == .popular {
            return apiManager.popularTitles.count
        } else if movieEnum == .nowPlaying {
            return apiManager.nowPlayingTitles.count
        } else if movieEnum == .upcoming {
            return apiManager.upcomingTitles.count
        } else {
            return apiManager.topRatedTitles.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch movieEnum {
        case .popular:
            let popular = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "popularCellsCell", for: indexPath) as! PopularMovieCellsCell
            popular.movieTitle.text = apiManager.popularTitles[safe: indexPath.row]
            popular.movieRating.text = "\(apiManager.popularRatings[safe: indexPath.row] ?? "nil") / 10"
            popular.moviePosterImage.image = apiManager.popularImages[safe: indexPath.row]
            return popular
        case .nowPlaying:
            let nowPlaying = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCellsCell", for: indexPath) as! NowPlayingCellsCell
            nowPlaying.movieTitle.text = apiManager.nowPlayingTitles[safe: indexPath.row]
            nowPlaying.movieReleaseTitle.text = apiManager.nowPlayingReleases[safe: indexPath.row]
            nowPlaying.movieImage.image = apiManager.nowPlayingImages[safe: indexPath.row]
            return nowPlaying
        case .upcoming:
            let upcoming = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCellsCell", for: indexPath) as! UpcomingCellsCell
            upcoming.movieTitle.text = apiManager.upcomingTitles[safe: indexPath.row]
            upcoming.movieReleaseTitle.text = apiManager.upcomingReleases[safe: indexPath.row]
            upcoming.movieImage.image = apiManager.upcomingImages[safe: indexPath.row]
            return upcoming
        case .topRated:
            let topRated = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellsCell", for: indexPath) as! TopRatedCellsCell
            topRated.movieTitle.text = apiManager.topRatedTitles[safe: indexPath.row]
            topRated.movieRating.text = apiManager.topRatedReleases[safe: indexPath.row]
            topRated.movieImage.image = apiManager.topRatedImages[safe: indexPath.row]
            return topRated
        }
    }
} // Data Source End


// Movie Cell Delegate
extension MovieCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
} // Delegate End


// Extension which makes the Array indexes able to go out of Index without crashing application.
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
