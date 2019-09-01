//
//  MovieCollectionViewCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/14/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    // HomeController of Collection View
    let homeController = HomeScreenController()
    // Movie Title
    var movieTitleAccomplice: [String] = []
    var movieFilmRatingAccomplice: [Float] = []
    // Image Variables
    var movieImageURLAccomplice: [String] = []
    // Movie Image
    var movieImages: [UIImage] = []
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    func setup() {
    // Inner Cell
        innerCollectionView.register(MovieCellsCell.self, forCellWithReuseIdentifier: "movieCellsCell")
        innerCollectionView.delegate = self
        innerCollectionView.dataSource = self
        innerCollectionView.showsHorizontalScrollIndicator = false
        addSubview(innerCollectionView)
        // Worked On July 21, Sunday 12:06
        initialSetup()
    }
    
    
    private func initialSetup() {
        let group = DispatchGroup()
        group.enter()
        homeController.popularMovieRequestTitles { (titles, filmRatings, nil, error) in
            if let error = error {
                print(error)
            }
            titles?.forEach({ (title) in
                self.movieTitleAccomplice.append(title)
            })
            filmRatings?.forEach({ (filmRating) in
                self.movieFilmRatingAccomplice.append(filmRating)
            })
        }
        group.leave()
        group.enter()
        self.finishTask {
            group.leave()
        }
    }
    
    
    private func finishTask(completionHandler: @escaping () -> Void) -> Void {
        let group = DispatchGroup()
        group.enter()
        self.homeController.processImageUrls { (_) in
            self.homeController.convertingFullURLsToImage(completionHandler: { (images) in
                self.movieImages = images
            })
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            self.reloadEverything()
        }
    }
    
    
    private func reloadEverything() {
        DispatchQueue.main.async {
            self.innerCollectionView.reloadData()
            self.homeController.reloadingMainCollectionView()
        }
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
    // Inner Cell
    class MovieCellsCell: UICollectionViewCell {
        // Movie Title
        let movieTitle: UILabel = {
            let label = UILabel(frame: CGRect(x: 0, y: 200, width: 150, height: 50))
            // Label Text
            label.text = "Loading"
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.left
            label.textColor = UIColor.white
            label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
            return label
        }()
        // Rating Image
        let movieRatingImage: UIImageView = {
            let ratingImage = UIImageView(frame: CGRect(x: 0, y: 250, width: 25, height: 25))
            ratingImage.layer.cornerRadius = 5
            // Setting the ImageViews Image
            ratingImage.backgroundColor = UIColor.white
            return ratingImage
        }()
        // Poster Image
        var moviePosterImage: UIImageView = {
            let posterImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 185))
            posterImage.layer.cornerRadius = 5
            posterImage.contentMode = .scaleAspectFill
            return posterImage
        }()
        // Movie Rating
        let movieRating: UILabel = {
            let rating = UILabel(frame: CGRect(x: 28, y: 250, width: 100, height: 25))
            // Rating Text
            rating.text = "/10"
            rating.numberOfLines = 1
            rating.textAlignment = NSTextAlignment.left
            rating.textColor = UIColor.white
            rating.font = UIFont(name: "Avenir-Light", size: 18)
            return rating
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            scrollingViewSetup()
        }
        
        
        private func scrollingViewSetup() {
            backgroundColor = UIColor.clear
            addSubview(movieRatingImage)
            addSubview(movieRating)
            addSubview(movieTitle)
            addSubview(moviePosterImage)
        }
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    } // Inner Class End
    
    // Data inside each Cell is shown here
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return movieTitleAccomplice.count
        }
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = innerCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCellsCell", for: indexPath) as! MovieCellsCell
        if indexPath.section == 0 {
            // Details here
            cell.movieTitle.text = movieTitleAccomplice[indexPath.row]
            cell.movieRating.text = "\(movieFilmRatingAccomplice[indexPath.row]) / 10"
            cell.moviePosterImage.image = movieImages[indexPath.row]
            return cell
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 80, right: 10)
    }

}
