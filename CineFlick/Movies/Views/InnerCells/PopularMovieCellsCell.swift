//
//  PopularMovieCellsView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class PopularMovieCellsView: UICollectionViewCell {
    static let reuseIdentifier = "PopularCellsCell"
    // Movie Title
    public lazy var movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popular"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor(named: "LabelColors")
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        return label
    }()
    // Poster Image
    public lazy var moviePosterImage: CustomImageView = {
        let posterImage = CustomImageView(frame: .zero)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.layer.cornerRadius = 10
        posterImage.clipsToBounds = true
        posterImage.contentMode = .scaleAspectFill
        return posterImage
    }()
    // Movie Rating
    public lazy var movieRating: UILabel = {
        let rating = UILabel(frame: .zero)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.text = "0%"
        rating.numberOfLines = 1
        rating.textAlignment = NSTextAlignment.left
        rating.textColor = UIColor(named: "LabelColors")
        rating.font = UIFont(name: "Avenir-Light", size: 18)
        return rating
    }()
    
    // MARK: Used as a Reference
    public lazy var backdropImage: CustomImageView = {
        let backdrop = CustomImageView()
        backdrop.layer.cornerRadius = 5
        backdrop.clipsToBounds = true
        backdrop.contentMode = .scaleAspectFill
        return backdrop
    }()
    public lazy var id: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    public lazy var overview: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    public lazy var runtime: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    public lazy var releaseDate: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.clear
        addSubview(movieRating)
        addSubview(movieTitle)
        addSubview(moviePosterImage)
        constraints()
    }
    
    
    private func constraints() {
        // Movie Title
        movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: 225).isActive = true
        movieTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Movie Poster Image
        moviePosterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        moviePosterImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        moviePosterImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        moviePosterImage.heightAnchor.constraint(equalToConstant: 225).isActive = true
        // Movie Rating
        movieRating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieRating.topAnchor.constraint(equalTo: topAnchor, constant: 275).isActive = true
        movieRating.widthAnchor.constraint(equalToConstant: 100).isActive = true
        movieRating.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
