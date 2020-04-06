//
//  MainScreenView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MainScreenView: UIView {
    // Buttons, Labels, etc.
    public lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 15, y: 0, width: 30, height: 30))
        if #available(iOS 13.0, *) {
            let systemImage = UIImage(systemName: "text.justify", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!
            let systemImageWithColor = systemImage.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
            imageView.contentMode = .scaleAspectFill
            imageView.image = systemImageWithColor
        } else {
            let assetImage = UIImage(named: "CategoryButton")!
            imageView.image = assetImage
        }
        
        return imageView
    }()
    public lazy var collectionView: UICollectionView = {
        let layout = MainCollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsSelection = false
        collection.backgroundColor = UIColor.clear
        return collection
    }()
    public lazy var refreshControl: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.tintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        controller.attributedTitle = NSAttributedString(string: "Fetching Movie Data ...")
        return controller
    }()
    public lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    // References
    public lazy var mainController = HomeScreenController()
    private var homeScreenDelegate: HomeScreenMainDelegate?
    private var homeScreenDataSource: HomeScreenMainDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        print("Umm 3")
        backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        // Collection View
        homeScreenDelegate = HomeScreenMainDelegate()
        homeScreenDataSource = HomeScreenMainDataSource(homeController: mainController)
        collectionView.delegate = homeScreenDelegate
        collectionView.dataSource = homeScreenDataSource
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
