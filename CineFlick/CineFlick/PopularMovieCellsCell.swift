//
//  MovieCellsCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 7/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

// Inner Cell
class PopularMovieCellsCell: UICollectionViewCell {
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
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.clear
        addSubview(movieRatingImage)
        addSubview(movieRating)
        addSubview(movieTitle)
        addSubview(moviePosterImage)
        print("Inside the cells Cell")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
