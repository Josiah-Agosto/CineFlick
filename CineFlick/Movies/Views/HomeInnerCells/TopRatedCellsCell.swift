//
//  TopRatedCellsView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class TopRatedCellsView: UICollectionViewCell {
    static let reuseIdentifier = "TopRatedCellsCell"
    // Title
    public lazy var movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top Rated"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor(named: "LabelColors")
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        return label
    }()
    // Image
    public lazy var movieImage: CustomImageView = {
        let image = CustomImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ImageNotFound")
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    // Release Date
    public lazy var movieRating: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor(named: "LabelColors")
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        return label
    }()
    
    // MARK: - Used as a Reference
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
    public lazy var rating: UILabel = {
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
        addSubview(movieTitle)
        addSubview(movieImage)
        addSubview(movieRating)
        constraints()
    }
    
    
    private func constraints() {
        // Movie Title
        movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: 225).isActive = true
        movieTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Movie Image
        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 225).isActive = true
        // Movie Rating
        movieRating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieRating.topAnchor.constraint(equalTo: topAnchor, constant: 275).isActive = true
        movieRating.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieRating.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
