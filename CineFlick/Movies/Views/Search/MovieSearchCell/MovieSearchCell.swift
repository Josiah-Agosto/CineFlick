//
//  MovieSearchCell.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class MovieSearchCell: UICollectionViewCell {
    // Properties / References
    static let reuseIdentifier = "searchCell"
    var cellId: String = ""
    // Title
    public lazy var movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.text = ""
        label.numberOfLines = 0
        // Font
        return label
    }()
    // Image View
    public lazy var movieImageView: CustomImageView = {
        let imageView = CustomImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // View
        backgroundColor = UIColor.clear
        // Subviews
        insertSubview(movieTitle, at: 0)
        insertSubview(movieImageView, at: 1)
        // Constraints
        constraints()
    }
    
    // MARK: - Constraints
    private func constraints() {
        // Title
        movieTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieTitle.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        movieTitle.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        // Image View
        movieImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
