//
//  SearchDetailView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/4/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class SearchDetailView: UIView {
    // Properties / References
    // Scroll View
    public lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor.clear
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor(named: "BackgroundColors")
        return scroll
    }()
    // Backdrop Image
       public lazy var backdropImage: CustomImageView = {
           let backdrop = CustomImageView(frame: .zero)
           backdrop.translatesAutoresizingMaskIntoConstraints = false
           backdrop.contentMode = .scaleAspectFill
           backdrop.backgroundColor = UIColor.clear
           backdrop.layer.cornerRadius = 8
           return backdrop
       }()
       // Movie Rating
       public lazy var movieRating: UILabel = {
           let rating = UILabel(frame: .zero)
           rating.translatesAutoresizingMaskIntoConstraints = false
           rating.text = "N/A"
           rating.numberOfLines = 1
           rating.backgroundColor = UIColor.clear
           rating.textAlignment = NSTextAlignment.center
           rating.layer.cornerRadius = 25
           rating.layer.borderWidth = 3
           rating.layer.borderColor = UIColor.green.cgColor
           rating.layer.masksToBounds = false
           rating.font = UIFont(name: "AvenirNext-Medium", size: 18)
           rating.textColor = UIColor.green
           return rating
       }()
       // Movie Title Placeholder
       public lazy var titlePlaceholder: UILabel = {
           let placeholder = UILabel(frame: .zero)
           placeholder.translatesAutoresizingMaskIntoConstraints = false
           placeholder.text = "Title:"
           placeholder.textColor = UIColor(named: "LabelColors")
           placeholder.backgroundColor = UIColor.clear
           placeholder.textAlignment = NSTextAlignment.left
           placeholder.numberOfLines = 1
           placeholder.font = UIFont(name: "AvenirNext", size: 15)
           return placeholder
       }()
       // Movie Title
       public lazy var movieTitle: UILabel = {
           let title = UILabel(frame: .zero)
           title.translatesAutoresizingMaskIntoConstraints = false
           title.text = "N/A"
           title.textColor = UIColor(named: "LabelColors")
           title.backgroundColor = UIColor.clear
           title.textAlignment = NSTextAlignment.left
           title.font = UIFont(name: "AvenirNext-Medium", size: 23)
           title.numberOfLines = 0
           return title
       }()
       // Release Date Placeholder
       public lazy var releasePlaceholder: UILabel = {
           let placeholder = UILabel(frame: .zero)
           placeholder.translatesAutoresizingMaskIntoConstraints = false
           placeholder.text = "Release Date:"
           placeholder.textColor = UIColor(named: "LabelColors")
           placeholder.backgroundColor = UIColor.clear
           placeholder.textAlignment = NSTextAlignment.left
           placeholder.numberOfLines = 1
           placeholder.font = UIFont(name: "AvenirNext", size: 15)
           return placeholder
       }()
       // Release Date
       public lazy var releaseDate: UILabel = {
           let releaseTitle = UILabel(frame: .zero)
           releaseTitle.translatesAutoresizingMaskIntoConstraints = false
           releaseTitle.text = "N/A"
           releaseTitle.textColor = UIColor(named: "LabelColors")
           releaseTitle.backgroundColor = UIColor.clear
           releaseTitle.textAlignment = NSTextAlignment.left
           releaseTitle.font = UIFont(name: "AvenirNext-Medium", size: 23)
           releaseTitle.numberOfLines = 0
           return releaseTitle
       }()
       // Overview Placeholder
       public lazy var overviewPlaceholder: UILabel = {
           let placeholder = UILabel(frame: .zero)
           placeholder.translatesAutoresizingMaskIntoConstraints = false
           placeholder.text = "Overview:"
           placeholder.textColor = UIColor(named: "LabelColors")
           placeholder.backgroundColor = UIColor.clear
           placeholder.textAlignment = NSTextAlignment.left
           placeholder.numberOfLines = 1
           placeholder.font = UIFont(name: "AvenirNext", size: 15)
           return placeholder
       }()
       // Movie Overview Message
       public lazy var overview: UILabel = {
           let overviewTitle = UILabel(frame: .zero)
           overviewTitle.translatesAutoresizingMaskIntoConstraints = false
           overviewTitle.text = "N/A"
           overviewTitle.textColor = UIColor(named: "LabelColors")
           overviewTitle.backgroundColor = UIColor.clear
           overviewTitle.textAlignment = NSTextAlignment.left
           overviewTitle.font = UIFont(name: "AvenirNext-Medium", size: 23)
           overviewTitle.numberOfLines = 0
           overviewTitle.clipsToBounds = true
           return overviewTitle
       }()
       // Runtime Placeholder
       public lazy var runtimePlaceholder: UILabel = {
           let placeholder = UILabel(frame: .zero)
           placeholder.translatesAutoresizingMaskIntoConstraints = false
           placeholder.text = "Runtime:"
           placeholder.textColor = UIColor(named: "LabelColors")
           placeholder.backgroundColor = UIColor.clear
           placeholder.textAlignment = NSTextAlignment.left
           placeholder.numberOfLines = 1
           placeholder.font = UIFont(name: "AvenirNext", size: 15)
           return placeholder
       }()
       // Runtime
       public lazy var runtime: UILabel = {
           let runtimeTitle = UILabel(frame: .zero)
           runtimeTitle.translatesAutoresizingMaskIntoConstraints = false
           runtimeTitle.text = "N/A"
           runtimeTitle.textColor = UIColor(named: "LabelColors")
           runtimeTitle.backgroundColor = UIColor.clear
           runtimeTitle.textAlignment = NSTextAlignment.left
           runtimeTitle.font = UIFont(name: "AvenirNext-Medium", size: 23)
           runtimeTitle.numberOfLines = 0
           return runtimeTitle
       }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor.clear
        // Subviews
        addSubview(scrollView)
        scrollView.addSubview(backdropImage)
        scrollView.addSubview(movieRating)
        scrollView.addSubview(titlePlaceholder)
        scrollView.addSubview(movieTitle)
        scrollView.addSubview(releasePlaceholder)
        scrollView.addSubview(releaseDate)
        scrollView.addSubview(runtimePlaceholder)
        scrollView.addSubview(runtime)
        scrollView.addSubview(overviewPlaceholder)
        scrollView.addSubview(overview)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        let screen = UIScreen.main.bounds
        // Scroll View
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // Inside Scroll View
        // Backdrop Image
        backdropImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        backdropImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        backdropImage.widthAnchor.constraint(equalToConstant: screen.width).isActive = true
        backdropImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        // Movie Rating
        movieRating.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        movieRating.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 234).isActive = true
        movieRating.widthAnchor.constraint(equalToConstant: 50).isActive = true
        movieRating.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Title Placeholder
        titlePlaceholder.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        titlePlaceholder.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: 4).isActive = true
        titlePlaceholder.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
        titlePlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Movie Title
        movieTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        movieTitle.topAnchor.constraint(equalTo: titlePlaceholder.bottomAnchor, constant: 4).isActive = true
        movieTitle.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
        // Runtime Placeholder
        runtimePlaceholder.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        runtimePlaceholder.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 4).isActive = true
        runtimePlaceholder.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
        runtimePlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Runtime
        runtime.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        runtime.topAnchor.constraint(equalTo: runtimePlaceholder.bottomAnchor, constant: 4).isActive = true
        runtime.widthAnchor.constraint(equalToConstant: 80).isActive = true
        // Release Placeholder
        releasePlaceholder.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        releasePlaceholder.topAnchor.constraint(equalTo: runtime.bottomAnchor, constant: 4).isActive = true
        releasePlaceholder.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
        releasePlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Release Date
        releaseDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        releaseDate.topAnchor.constraint(equalTo: releasePlaceholder.bottomAnchor, constant: 4).isActive = true
        releaseDate.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
        // Overview Placeholder
        overviewPlaceholder.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        overviewPlaceholder.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 4).isActive = true
        overviewPlaceholder.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
        overviewPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Overview
        overview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        overview.topAnchor.constraint(equalTo: overviewPlaceholder.bottomAnchor, constant: 4).isActive = true
        overview.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
