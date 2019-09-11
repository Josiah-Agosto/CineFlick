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
    private var movieNetworkManager = NetworkManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        // This wasn't a closire before but i foudn this way to work.
        self.movieNetworkManager.makeApiCalls {
            // This is also here just for now. I had everything before without the closure part and it kept calling the reload first.
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 20, execute: {
                DispatchQueue.main.async {
                    self.innerCollectionView.reloadData()
                    print("Reloaded???")
                }
            })
        }
    }
    
    
    func setup() {
        innerCollectionView.delegate = self
        innerCollectionView.dataSource = self
        innerCollectionView.showsHorizontalScrollIndicator = false
        innerCollectionView.allowsSelection = true
        innerCollectionView.register(PopularMovieCellsCell.self, forCellWithReuseIdentifier: "movieCellsCell")
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


extension MovieCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Data inside each Cell is shown here
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            // Popular
            return movieNetworkManager.movieTitleAccomplice.count
        } else if section == 1 {
            // Now Playing
            return movieNetworkManager.nowPlayingTitles.count
        } else if section == 2 {
            // Upcoming
            return movieNetworkManager.upcomingTitles.count
        } else {
            // Top Rated
            return movieNetworkManager.topRatedTitles.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            // Popular
            let popular = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCellsCell", for: indexPath) as! PopularMovieCellsCell
            popular.movieTitle.text = movieNetworkManager.movieTitleAccomplice[indexPath.row]
            popular.movieRating.text = "\(movieNetworkManager.movieFilmRatingAccomplice[indexPath.row]) / 10"
            popular.moviePosterImage.image = movieNetworkManager.movieImages[indexPath.row]
            return popular
        } else if indexPath.item == 1 {
            // Now Playing
            let nowPlaying = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCellsCell", for: indexPath) as! NowPlayingCellsCell
            nowPlaying.movieTitle.text = movieNetworkManager.nowPlayingTitles[indexPath.row]
            nowPlaying.movieReleaseTitle.text = "\(movieNetworkManager.nowPlayingReleaseDates[indexPath.row])"
            nowPlaying.movieImage.image = movieNetworkManager.nowPlayingImages[indexPath.row]
            return nowPlaying
        } else if indexPath.item == 2 {
            // Upcoming
            let upcoming = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCellsCell", for: indexPath) as! UpcomingCellsCell
            upcoming.movieTitle.text = movieNetworkManager.upcomingTitles[indexPath.row]
            upcoming.movieReleaseTitle.text = "\(movieNetworkManager.upcomingReleaseDates[indexPath.row])"
            upcoming.movieImage.image = movieNetworkManager.upcomingImages[indexPath.row]
            return upcoming
        } else {
            // Top Rated
            let topRated = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellsCell", for: indexPath) as! TopRatedCellsCell
            topRated.movieTitle.text = movieNetworkManager.topRatedTitles[indexPath.row]
            topRated.movieRating.text = "\(movieNetworkManager.topRatedFilmRatings[indexPath.row]) / 10"
            topRated.movieImage.image = movieNetworkManager.topRatedImages[indexPath.row]
            return topRated
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 80, right: 10)
    }
    
}
