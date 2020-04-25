//
//  CategoryView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 6/11/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class SlideView: UIView {
    // Properties
    // Title
    public lazy var categoryTitle: UILabel = {
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Categories"
        title.textColor = UIColor(named: "LabelColors")
        title.textAlignment = NSTextAlignment.left
        title.font = UIFont(name: "AvenirNext-DemiBold", size: 32)
        return title
    }()
    // Movie Button
    public lazy var movieButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(UIColor(named: "LabelColors"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    // About Button
    public lazy var aboutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("About", for: .normal)
        button.setTitleColor(UIColor(named: "LabelColors"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    // Movie Image
    public lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            let movieImage = UIImage(systemName: "film")!
            let movieImageWithColor = movieImage.withTintColor(UIColor(named: "LabelColors")!, renderingMode: .alwaysOriginal)
            imageView.image = movieImageWithColor
        } else {
            imageView.image = UIImage(named: "ImageNotFound")
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // About Image
    public lazy var aboutImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            let movieImage = UIImage(systemName: "gear")!
            let movieImageWithColor = movieImage.withTintColor(UIColor(named: "LabelColors")!, renderingMode: .alwaysOriginal)
            imageView.image = movieImageWithColor
        } else {
            // Fallback on earlier versions
            imageView.image = UIImage(named: "ImageNotFound")
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // View
        backgroundColor = UIColor(named: "BackgroundColors")
        // Adding to View
        addSubview(categoryTitle)
        addSubview(movieButton)
        addSubview(movieImageView)
        addSubview(aboutButton)
        addSubview(aboutImageView)
        // Configuring the Constraints
        configureConstraints()
    }
    
    // MARK: - Constraints
    private func configureConstraints() {
        // Category
        categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        categoryTitle.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        categoryTitle.widthAnchor.constraint(equalToConstant: 250).isActive = true
        categoryTitle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // Movies Image View
        movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Movies
        movieButton.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        movieButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        movieButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // About Image View
        aboutImageView.topAnchor.constraint(equalTo: topAnchor, constant: 220).isActive = true
        aboutImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        aboutImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        aboutImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // About
        aboutButton.topAnchor.constraint(equalTo: topAnchor, constant: 220).isActive = true
        aboutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        aboutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        aboutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
