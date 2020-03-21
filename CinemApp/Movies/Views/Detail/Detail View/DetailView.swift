//
//  DetailView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/21/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIView {
    // MARK: - UI Components
    public lazy var castCollectionView: UICollectionView = {
        let viewLayout = CastCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = false
        collectionView.layer.cornerRadius = 5
        collectionView.bounces = false
        return collectionView
    }()
// Appearance
    // Scroll View
    public lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor.clear
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.layer.cornerRadius = 10
        scroll.contentSize.height = 875
        return scroll
    }()
    // Backdrop Image
    public lazy var backdropImage: UIImageView = {
        let backdrop = UIImageView()
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        backdrop.backgroundColor = UIColor.clear
        backdrop.layer.cornerRadius = 8
        backdrop.layer.layoutIfNeeded()
        return backdrop
    }()
    // Movie Rating
    public lazy var movieRating: UILabel = {
        let rating = UILabel()
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.text = "83"
        rating.numberOfLines = 1
        rating.backgroundColor = UIColor.clear
        rating.textAlignment = NSTextAlignment.center
        rating.layer.cornerRadius = 25
        rating.layer.borderWidth = 3
        rating.layer.borderColor = UIColor.green.cgColor
        rating.font = UIFont(name: "AvenirNext-Bold", size: 20)
        rating.textColor = UIColor.green
        return rating
    }()
    // Movie Title Placeholder
    public lazy var titlePlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Title:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Movie Title
    public lazy var movieTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Title"
        title.numberOfLines = 0
        title.backgroundColor = UIColor.clear
        title.textAlignment = NSTextAlignment.left
        title.font = UIFont(name: "AvenirNext-Bold", size: 25)
        return title
    }()
    // Release Date Placeholder
    public lazy var releasePlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Release Date:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Release Date
    public lazy var releaseDate: UILabel = {
        let releaseTitle = UILabel()
        releaseTitle.translatesAutoresizingMaskIntoConstraints = false
        releaseTitle.text = "Release"
        releaseTitle.backgroundColor = UIColor.clear
        releaseTitle.numberOfLines = 1
        releaseTitle.textAlignment = NSTextAlignment.left
        releaseTitle.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return releaseTitle
    }()
    // Overview Placeholder
    public lazy var overviewPlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Overview:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Movie Overview Message
    public lazy var overview: UILabel = {
        let overviewTitle = UILabel()
        overviewTitle.translatesAutoresizingMaskIntoConstraints = false
        overviewTitle.text = "Overview"
        overviewTitle.numberOfLines = 0
        overviewTitle.backgroundColor = UIColor.clear
        overviewTitle.textAlignment = NSTextAlignment.left
        overviewTitle.textColor = UIColor.white
        overviewTitle.sizeToFit()
        overviewTitle.font = UIFont(name: "AvenirNext", size: 18)
        return overviewTitle
    }()
    // Runtime Placeholder
    public lazy var runtimePlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Runtime:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Runtime
    public lazy var runtime: UILabel = {
        let runtimeTitle = UILabel()
        runtimeTitle.translatesAutoresizingMaskIntoConstraints = false
        runtimeTitle.text = "Runtime"
        runtimeTitle.numberOfLines = 1
        runtimeTitle.backgroundColor = UIColor.clear
        runtimeTitle.textAlignment = NSTextAlignment.left
        runtimeTitle.font = UIFont(name: "AvenirNext", size: 12)
        return runtimeTitle
    }()
    // Cast Placeholder
    public lazy var castPlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Cast:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Delegates
    private let castDelegate = CastCollectionViewDelegate()
    public let castDataSource = CastCollectionViewDataSource()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // View
        backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 0)
        // Cast Collection View
        castCollectionView.delegate = castDelegate
        castCollectionView.dataSource = castDataSource
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.reuseIdentifier)
        // Subviews
        addSubview(scrollView)
        // To Scroll View, In order
        scrollView.addSubview(backdropImage)
        scrollView.addSubview(movieRating)
        scrollView.addSubview(titlePlaceholder)
        scrollView.addSubview(movieTitle)
        scrollView.addSubview(runtimePlaceholder)
        scrollView.addSubview(runtime)
        scrollView.addSubview(releasePlaceholder)
        scrollView.addSubview(releaseDate)
        scrollView.addSubview(overviewPlaceholder)
        scrollView.addSubview(overview)
        scrollView.addSubview(castPlaceholder)
        scrollView.addSubview(castCollectionView)
        constraints()
    }
    
    // MARK: Constraints
    private func constraints() {
        let screenWidth = UIScreen.main.bounds.width
        // Scroll View
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        // Inside Scroll View
        // Backdrop Image
        backdropImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        backdropImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        backdropImage.widthAnchor.constraint(equalToConstant: screenWidth - 40).isActive = true
        backdropImage.heightAnchor.constraint(equalToConstant: 210).isActive = true
        // Movie Rating
        movieRating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        movieRating.topAnchor.constraint(equalTo: topAnchor, constant: 160).isActive = true
        movieRating.widthAnchor.constraint(equalToConstant: 50).isActive = true
        movieRating.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Title Placeholder
        titlePlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titlePlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 230).isActive = true
        titlePlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        titlePlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Movie Title
        movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
        movieTitle.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
        // Runtime
        runtimePlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        runtimePlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 340).isActive = true
        runtimePlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        runtimePlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Runtime
        runtime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        runtime.topAnchor.constraint(equalTo: topAnchor, constant: 360).isActive = true
        runtime.widthAnchor.constraint(equalToConstant: 80).isActive = true
        runtime.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Release
        releasePlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        releasePlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 400).isActive = true
        releasePlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        releasePlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Release Date
        releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        releaseDate.topAnchor.constraint(equalTo: topAnchor, constant: 420).isActive = true
        releaseDate.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        releaseDate.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Overview Placeholder
        overviewPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        overviewPlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 460).isActive = true
        overviewPlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        overviewPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Overview
        overview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        overview.topAnchor.constraint(equalTo: topAnchor, constant: 480).isActive = true
        overview.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        overview.heightAnchor.constraint(equalToConstant: 180).isActive = true
        // Cast Placeholder
        castPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        castPlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 670).isActive = true
        castPlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        castPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Cast Collection View
        castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        castCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 700).isActive = true
        castCollectionView.widthAnchor.constraint(equalToConstant: screenWidth - 10).isActive = true
        castCollectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
} // Class End
