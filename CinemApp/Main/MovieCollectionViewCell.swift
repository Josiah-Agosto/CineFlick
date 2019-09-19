//
//  MovieCollectionViewCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/14/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

public enum MovieSectionEnum {
    case popular
    case nowPlaying
    case upcoming
    case topRated
}

class MovieCollectionViewCell: UICollectionViewCell {
    // Variables
    var movieSection: MovieSectionEnum = .popular
    // Inner Cell
    let innerCollectionView: UICollectionView = {
        let layout = InnerCollectionViewFlowLayout()
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
    var movieNetworkManager = NetworkManager()
    
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
    // Data inside each Cell is shown here
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movieSection == .popular {
            return movieNetworkManager.popularTitles.count
        } else if movieSection == .nowPlaying{
            return movieNetworkManager.nowPlayingTitles.count
        } else if movieSection == .upcoming {
            return movieNetworkManager.upcomingTitles.count
        } else {
            return movieNetworkManager.topRatedTitles.count
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch movieSection {
        case .popular:
            // Popular
            let popular = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "popularCellsCell", for: indexPath) as! PopularMovieCellsCell
            popular.movieTitle.text = movieNetworkManager.popularTitles[safe: indexPath.row]
            popular.movieRating.text = "\(movieNetworkManager.popularFilmRating[safe: indexPath.row] ?? "nil") / 10"
            popular.moviePosterImage.image = movieNetworkManager.popularImages[safe: indexPath.row]
            print("Popular: \(movieNetworkManager.popularTitles)")
            return popular
        case .nowPlaying:
            // Now Playing
            let nowPlaying = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCellsCell", for: indexPath) as! NowPlayingCellsCell
            nowPlaying.movieTitle.text = movieNetworkManager.nowPlayingTitles[safe: indexPath.row]
            nowPlaying.movieReleaseTitle.text = "\(movieNetworkManager.nowPlayingReleaseDates[safe: indexPath.row] ?? "nil")"
            nowPlaying.movieImage.image = movieNetworkManager.nowPlayingImages[safe: indexPath.row]
            print("Now Playing: \(movieNetworkManager.upcomingTitles)")
            return nowPlaying
        case .upcoming:
            // Upcoming
            let upcoming = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCellsCell", for: indexPath) as! UpcomingCellsCell
            upcoming.movieTitle.text = movieNetworkManager.upcomingTitles[safe: indexPath.row]
            upcoming.movieReleaseTitle.text = "\(movieNetworkManager.upcomingReleaseDates[safe: indexPath.row] ?? "nil")"
            upcoming.movieImage.image = movieNetworkManager.upcomingImages[safe: indexPath.row]
            print("Upcoming: \(movieNetworkManager.upcomingTitles)")
            return upcoming
        case .topRated:
            // Top Rated
            let topRated = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellsCell", for: indexPath) as! TopRatedCellsCell
            topRated.movieTitle.text = movieNetworkManager.topRatedTitles[safe: indexPath.row]
            topRated.movieRating.text = "\(movieNetworkManager.topRatedFilmRatings[safe: indexPath.row] ?? "nil") / 10"
            topRated.movieImage.image = movieNetworkManager.topRatedImages[safe: indexPath.row]
            print("Top Rated: \(movieNetworkManager.topRatedTitles)")
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
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
} // Delegate End


// Extension which makes the Array indexes able to go out of Index without crashing application.
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
