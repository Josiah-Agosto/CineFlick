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
    // Inner Cell
    let innerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.scrollDirection = .horizontal
        // Inner Collection View NOT Cell
        let initializingCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300), collectionViewLayout: layout)
        initializingCollectionView.backgroundColor = UIColor.clear
        return initializingCollectionView
    }()
    // Date Formatter
    private let dateFormatter = DateFormatter()
    // References
    private var popularRequest: PopularProcess!
    private var nowPlayingRequest: NowPlayingProcess!
    private var upcomingRequest: UpcomingProcess!
    private var topRatedRequest: TopRatedProcess!
    private var movieNetworkManager: NetworkManager!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    public func reloadViews() {
        DispatchQueue.main.async {
            self.innerCollectionView.reloadData()
        }
    }
    
    
    func setup() {
        innerCollectionView.delegate = self
        innerCollectionView.dataSource = self
        innerCollectionView.showsHorizontalScrollIndicator = false
        innerCollectionView.allowsSelection = true
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


extension MovieCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Data inside each Cell is shown here
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieNetworkManager = NetworkManager()
        if section == 1 {
            // Now Playing
            return movieNetworkManager.nowPlayingTitles.count
        } else if section == 2 {
            // Upcoming
            return movieNetworkManager.upcomingTitles.count
        } else if section == 3 {
            // Top Rated
            return movieNetworkManager.topRatedTitles.count
        } else {
            // Popular
            return movieNetworkManager.movieTitleAccomplice.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        popularRequest = PopularProcess()
        nowPlayingRequest = NowPlayingProcess()
        topRatedRequest = TopRatedProcess()
        if indexPath.section == 1 {
            print("Inside cellForItem")
            // Now Playing
            let nowPlaying = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCellsCell", for: indexPath) as! NowPlayingCellsCell
            nowPlaying.movieTitle.text = movieNetworkManager.nowPlayingTitles[indexPath.row]
            nowPlaying.movieReleaseTitle.text = "\(movieNetworkManager.nowPlayingReleaseDates[indexPath.row])"
            nowPlaying.movieImage.image = movieNetworkManager.nowPlayingImages[indexPath.row]
            return nowPlaying
        } else if indexPath.section == 2 {
            print("Inside cellForItem")
            // Upcoming
            let upcoming = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCellsCell", for: indexPath) as! UpcomingCellsCell
            upcoming.movieTitle.text = movieNetworkManager.upcomingTitles[indexPath.row]
            upcoming.movieReleaseTitle.text = "\(movieNetworkManager.upcomingReleaseDates[indexPath.row])"
            upcoming.movieImage.image = movieNetworkManager.upcomingImages[indexPath.row]
            return upcoming
        } else if indexPath.section == 3 {
            print("Inside cellForItem")
            // Top Rated
            let topRated = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellsCell", for: indexPath) as! TopRatedCellsCell
            topRated.movieTitle.text = movieNetworkManager.topRatedTitles[indexPath.row]
            topRated.movieRating.text = "\(movieNetworkManager.topRatedFilmRatings[indexPath.row]) / 10"
            topRated.movieImage.image = movieNetworkManager.topRatedImages[indexPath.row]
            return topRated
        } else {
            print("Inside cellForItem")
            // Popular
            let popular = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCellsCell", for: indexPath) as! PopularMovieCellsCell
            popular.movieTitle.text = movieNetworkManager.movieTitleAccomplice[indexPath.row]
            popular.movieRating.text = "\(movieNetworkManager.movieFilmRatingAccomplice[indexPath.row]) / 10"
            popular.moviePosterImage.image = movieNetworkManager.movieImages[indexPath.row]
            return popular
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 80, right: 10)
    }
    
}
