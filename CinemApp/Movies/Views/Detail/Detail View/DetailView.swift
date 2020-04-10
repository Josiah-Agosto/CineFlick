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
    public lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        if #available(iOS 13.0, *) {
            let xmarkImage = UIImage(systemName: "xmark.circle.fill")!
            let xmarkWithColor = xmarkImage.withTintColor(UIColor.black, renderingMode: .automatic)
            button.setImage(xmarkWithColor, for: .normal)
        } else {
            button.setImage(UIImage(named: "Detail Close Button"), for: .normal)
        }
        return button
    }()
    public lazy var castCollectionView: UICollectionView = {
        let viewLayout = CastCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsSelection = false
        collectionView.layer.cornerRadius = 5
        return collectionView
    }()
    // Scroll View
    public lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor.black
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    public lazy var contentHolder: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    // Backdrop Image
    public lazy var backdropImage: UIImageView = {
        let backdrop = UIImageView(frame: .zero)
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
        rating.text = "99"
        rating.numberOfLines = 1
        rating.backgroundColor = UIColor.clear
        rating.textAlignment = NSTextAlignment.center
        rating.layer.cornerRadius = 25
        rating.layer.borderWidth = 3
        rating.layer.borderColor = UIColor.green.cgColor
        rating.layer.masksToBounds = false
        rating.shadowColor = UIColor.black
        rating.layer.shadowOpacity = 0.5
        rating.layer.shadowOffset = CGSize(width: rating.frame.width, height: 3)
        rating.layer.shadowRadius = 3.0
        rating.font = UIFont(name: "AvenirNext-Medium", size: 18)
        rating.textColor = UIColor.green
        return rating
    }()
    // Movie Title Placeholder
    public lazy var titlePlaceholder: UILabel = {
        let placeholder = UILabel(frame: .zero)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Title:"
        placeholder.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
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
        title.text = "Title"
        title.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        title.backgroundColor = UIColor.clear
        title.textAlignment = NSTextAlignment.left
        title.font = UIFont(name: "AvenirNext-Medium", size: 25)
        title.numberOfLines = 0
        return title
    }()
    // Release Date Placeholder
    public lazy var releasePlaceholder: UILabel = {
        let placeholder = UILabel(frame: .zero)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Release Date:"
        placeholder.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
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
        releaseTitle.text = "Release"
        releaseTitle.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
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
        placeholder.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
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
        overviewTitle.text = "Overview"
        overviewTitle.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        overviewTitle.backgroundColor = UIColor.clear
        overviewTitle.textAlignment = NSTextAlignment.left
        overviewTitle.textColor = UIColor.white
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
        placeholder.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
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
        runtimeTitle.text = "Runtime"
        runtimeTitle.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        runtimeTitle.backgroundColor = UIColor.clear
        runtimeTitle.textAlignment = NSTextAlignment.left
        runtimeTitle.font = UIFont(name: "AvenirNext-Medium", size: 20)
        runtimeTitle.numberOfLines = 0
        return runtimeTitle
    }()
    // Cast Placeholder
    public lazy var castPlaceholder: UILabel = {
        let placeholder = UILabel(frame: .zero)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.text = "Cast:"
        placeholder.textColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        placeholder.backgroundColor = UIColor.clear
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext", size: 15)
        return placeholder
    }()
    public lazy var detailController = DetailViewController()
    // Delegates
    private var castDelegate: CastCollectionViewDelegate?
    public var castDataSource: CastCollectionViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // Cast Collection View
        castDelegate = CastCollectionViewDelegate()
        castDataSource = CastCollectionViewDataSource(detailController: detailController)
        detailController.detailManager.castPropertiesDelegate = castDataSource
        castCollectionView.delegate = castDelegate
        castCollectionView.dataSource = castDataSource
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.reuseIdentifier)
        // Subviews
        addSubview(scrollView)
        // To Scroll View, In order
        scrollView.addSubview(contentHolder)
        contentHolder.addSubview(backdropImage)
        contentHolder.addSubview(movieRating)
        contentHolder.addSubview(titlePlaceholder)
        contentHolder.addSubview(movieTitle)
        contentHolder.addSubview(runtimePlaceholder)
        contentHolder.addSubview(runtime)
        contentHolder.addSubview(releasePlaceholder)
        contentHolder.addSubview(releaseDate)
        contentHolder.addSubview(overviewPlaceholder)
        contentHolder.addSubview(overview)
        contentHolder.addSubview(castPlaceholder)
        contentHolder.addSubview(castCollectionView)
        constraints()
        print(scrollView.contentSize)
        print(castCollectionView.frame)
    }
    
    // MARK: Constraints
    private func constraints() {
        let screenWidth = UIScreen.main.bounds.width
        // Scroll View
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // Content Holder
        contentHolder.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentHolder.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentHolder.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentHolder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // Inside Scroll View
        // Backdrop Image
        backdropImage.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor).isActive = true
        backdropImage.topAnchor.constraint(equalTo: contentHolder.topAnchor).isActive = true
        backdropImage.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        backdropImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        // Movie Rating
        movieRating.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        movieRating.topAnchor.constraint(equalTo: contentHolder.topAnchor, constant: 234).isActive = true
        movieRating.widthAnchor.constraint(equalToConstant: 50).isActive = true
        movieRating.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Title Placeholder
        titlePlaceholder.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        titlePlaceholder.topAnchor.constraint(equalTo: backdropImage.bottomAnchor, constant: 4).isActive = true
        titlePlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        titlePlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Movie Title
        movieTitle.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        movieTitle.topAnchor.constraint(equalTo: titlePlaceholder.bottomAnchor, constant: 4).isActive = true
        movieTitle.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        // Runtime Placeholder
        runtimePlaceholder.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        runtimePlaceholder.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 4).isActive = true
        runtimePlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        runtimePlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Runtime
        runtime.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        runtime.topAnchor.constraint(equalTo: runtimePlaceholder.bottomAnchor, constant: 4).isActive = true
        runtime.widthAnchor.constraint(equalToConstant: 80).isActive = true
        // Release Placeholder
        releasePlaceholder.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        releasePlaceholder.topAnchor.constraint(equalTo: runtime.bottomAnchor, constant: 4).isActive = true
        releasePlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        releasePlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Release Date
        releaseDate.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        releaseDate.topAnchor.constraint(equalTo: releasePlaceholder.bottomAnchor, constant: 4).isActive = true
        releaseDate.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        // Overview Placeholder
        overviewPlaceholder.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        overviewPlaceholder.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 4).isActive = true
        overviewPlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        overviewPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Overview
        overview.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        overview.topAnchor.constraint(equalTo: overviewPlaceholder.bottomAnchor, constant: 4).isActive = true
        overview.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        // Cast Placeholder
        castPlaceholder.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 16).isActive = true
        castPlaceholder.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 4).isActive = true
        castPlaceholder.widthAnchor.constraint(equalToConstant: screenWidth - 32).isActive = true
        castPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // Cast Collection View
        castCollectionView.leadingAnchor.constraint(equalTo: contentHolder.leadingAnchor, constant: 4).isActive = true
        castCollectionView.topAnchor.constraint(equalTo: castPlaceholder.bottomAnchor, constant: 6).isActive = true
        castCollectionView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        castCollectionView.heightAnchor.constraint(equalToConstant: 185).isActive = true
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
} // Class End
