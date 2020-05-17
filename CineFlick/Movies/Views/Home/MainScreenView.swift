//
//  MainScreenView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MainScreenView: UIView {
    // Properties
    public lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        if #available(iOS 13.0, *) {
            let systemImage = UIImage(systemName: "text.justify", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!
            let systemImageWithColor = systemImage.withTintColor(UIColor(named: "LabelColors")!, renderingMode: .alwaysOriginal)
            imageView.contentMode = .scaleAspectFill
            imageView.image = systemImageWithColor
        } else {
            let assetImage = UIImage(named: "CategoryButton")!
            imageView.image = assetImage
        }
        return imageView
    }()
    // Main Collection View
    public lazy var collectionView: UICollectionView = {
        let layout = MainCollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsSelection = false
        collection.backgroundColor = UIColor.clear
        return collection
    }()
    // Refresh Control
    public lazy var refreshControl: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.tintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        controller.attributedTitle = NSAttributedString(string: "Fetching Movie Data ...")
        return controller
    }()
    // Search Button
    public lazy var searchBarButtonItem: UIBarButtonItem = {
        let searchButton = UIBarButtonItem()
        return searchButton
    }()
    // Left Bar Button
    public lazy var slideMenuBarButtonItem: UIBarButtonItem = {
        let slideHolder = UIBarButtonItem()
        slideHolder.tintColor = UIColor(named: "LabelColors")
        return slideHolder
    }()
    // Custom Title View
    public lazy var customTitleView: CustomTitleView = {
        let view = CustomTitleView(frame: .zero)
        view.backgroundColor = UIColor.clear
        return view
    }()
    public lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    public lazy var blurEffectView: UIVisualEffectView? = UIVisualEffectView()
    public lazy var mainController = HomeScreenController()
    public lazy var movieCollectionViewCell = MovieCollectionViewCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        if #available(iOS 13.0, *) {
            backgroundColor = UIColor.systemGray5
        } else {
            backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 1.0)
        }
        // Detail
        mainController.detailController = DetailViewController()
        // Collection View
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "firstId")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "secondId")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "thirdId")
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "fourthId")
        // Subviews
        self.addSubview(collectionView)
        // Checks if the OS is greater that 10.0
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        constraints()
    }
    
    
    private func constraints() {
        // Constraints
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 90).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
} // Main Screen View End
