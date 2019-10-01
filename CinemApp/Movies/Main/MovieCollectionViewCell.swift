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
        let initializingCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 10, height: 300), collectionViewLayout: layout)
        initializingCollectionView.backgroundColor = UIColor.clear
        return initializingCollectionView
    }()
    // Movie Enum
    var movieEnum: MovieSectionEnum = .popular
    // Reference to API Manager
    var apiManager: APINetworkManager!
    var castClient = CastClient()
    var imageClient = ImageClient()
    lazy var detailManager = DetailNetworkManager()
    // Other References
    private let mainWindow = UIApplication.shared.keyWindow
    lazy var home = HomeScreenController()
    let detail = DetailView()
    private let group = DispatchGroup()
    
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
            popular.movieRating.text = "\(apiManager.popularRatings[safe: indexPath.row] ?? "nil")%"
            popular.moviePosterImage.image = apiManager.popularImages[safe: indexPath.row]
            // For Detail View
            popular.backdropImage.image = apiManager.popularBackdropImages[safe: indexPath.row]
            popular.id.text = apiManager.popularIds[safe: indexPath.row]
            popular.overview.text = apiManager.popularOverview[safe: indexPath.row]
            popular.runtime.text = apiManager.popularRuntime[safe: indexPath.row]
            return popular
        case .nowPlaying:
            let nowPlaying = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "nowPlayingCellsCell", for: indexPath) as! NowPlayingCellsCell
            nowPlaying.movieTitle.text = apiManager.nowPlayingTitles[safe: indexPath.row]
            nowPlaying.movieReleaseTitle.text = apiManager.nowPlayingReleases[safe: indexPath.row]
            nowPlaying.movieImage.image = apiManager.nowPlayingImages[safe: indexPath.row]
            // For Detail View
            nowPlaying.backdropImage.image = apiManager.nowPlayingBackdropImages[safe: indexPath.row]
            nowPlaying.id.text = apiManager.nowPlayingIds[safe: indexPath.row]
            nowPlaying.overview.text = apiManager.nowPlayingOverview[safe: indexPath.row]
            nowPlaying.runtime.text = apiManager.nowPlayingRuntime[safe: indexPath.row]
            nowPlaying.rating.text = apiManager.nowPlayingRatings[safe: indexPath.row]
            return nowPlaying
        case .upcoming:
            let upcoming = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCellsCell", for: indexPath) as! UpcomingCellsCell
            upcoming.movieTitle.text = apiManager.upcomingTitles[safe: indexPath.row]
            upcoming.movieReleaseTitle.text = apiManager.upcomingReleases[safe: indexPath.row]
            upcoming.movieImage.image = apiManager.upcomingImages[safe: indexPath.row]
            // For Detail View
            upcoming.backdropImage.image = apiManager.upcomingBackdropImages[safe: indexPath.row]
            upcoming.id.text = apiManager.upcomingIds[safe: indexPath.row]
            upcoming.overview.text = apiManager.upcomingOverview[safe: indexPath.row]
            upcoming.runtime.text = apiManager.upcomingRuntime[safe: indexPath.row]
            upcoming.rating.text = apiManager.upcomingRatings[safe: indexPath.row]
            return upcoming
        case .topRated:
            let topRated = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "topRatedCellsCell", for: indexPath) as! TopRatedCellsCell
            topRated.movieTitle.text = apiManager.topRatedTitles[safe: indexPath.row]
            topRated.movieRating.text = apiManager.topRatedReleases[safe: indexPath.row]
            topRated.movieImage.image = apiManager.topRatedImages[safe: indexPath.row]
            // For Detail View
            topRated.backdropImage.image = apiManager.topRatedBackdropImages[safe: indexPath.row]
            topRated.id.text = apiManager.topRatedIds[safe: indexPath.row]
            topRated.overview.text = apiManager.topRatedOverview[safe: indexPath.row]
            topRated.runtime.text = apiManager.topRatedRuntime[safe: indexPath.row]
            topRated.rating.text = apiManager.topRatedRatings[safe: indexPath.row]
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
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch movieEnum {
        case .popular:
            let cell = collectionView.cellForItem(at: indexPath) as! PopularMovieCellsCell
            detail.movieTitle.text = cell.movieTitle.text
            detail.backdropImage.image = cell.backdropImage.image
            detail.overview.text = cell.overview.text
            detail.runtime.text = cell.runtime.text
            detail.movieRating.text = cell.movieRating.text
            let id = apiManager.popularIds[safe: indexPath.row] ?? ""
            // Showing it to Detail
            group.enter()
            self.detailManager.detailCast(id) { (name, characterName, image, totalCellCount) in
                self.detail.name = name
                self.detail.charName = characterName
                self.detail.profileImage = image
                self.detail.castCountForSection = totalCellCount
                self.group.leave()
            }
            group.notify(queue: DispatchQueue.main) {
                self.detail.castCollectionView.reloadData()
            }
            // Adding View Controller to Screen
            mainWindow?.addSubview(detail.view)
        case .nowPlaying:
            let cell2 = collectionView.cellForItem(at: indexPath) as! NowPlayingCellsCell
            detail.movieTitle.text = cell2.movieTitle.text
            detail.backdropImage.image = cell2.backdropImage.image
            detail.overview.text = cell2.overview.text
            detail.runtime.text = cell2.runtime.text
            // Adding View Controller to Screen
            mainWindow?.addSubview(detail.view)
        case .upcoming:
            let cell3 = collectionView.cellForItem(at: indexPath) as! UpcomingCellsCell
            detail.movieTitle.text = cell3.movieTitle.text
            detail.backdropImage.image = cell3.backdropImage.image
            detail.overview.text = cell3.overview.text
            detail.runtime.text = cell3.runtime.text
            // Adding View Controller to Screen
            mainWindow?.addSubview(detail.view)
        case .topRated:
            let cell4 = collectionView.cellForItem(at: indexPath) as! TopRatedCellsCell
            detail.movieTitle.text = cell4.movieTitle.text
            detail.backdropImage.image = cell4.backdropImage.image
            detail.overview.text = cell4.overview.text
            detail.runtime.text = cell4.runtime.text
            // Adding View Controller to Screen
            mainWindow?.addSubview(detail.view)
        }
        
    }
} // Delegate End


// Extension which makes the Array indexes able to go out of Index without crashing application.
public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
