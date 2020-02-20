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
    public var categoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "CategoryButton"), for: .normal)
        return button
    }()
    public var collectionView: UICollectionView = {
        let layout = MainCollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsSelection = false
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let headerId = "headerId"
        let secondHeaderId = "secondId"
        let thirdHeaderId = "thirdId"
        let fourthHeaderId = "fourthHeaderId"
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: secondHeaderId)
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: thirdHeaderId)
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fourthHeaderId)
        collection.backgroundColor = UIColor.clear
        return collection
    }()
    // References
    public var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    public var refreshControl: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.tintColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        controller.attributedTitle = NSAttributedString(string: "Fetching Movie Data ...")
        return controller
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // Subviews
        addSubview(categoryButton)
        addSubview(collectionView)
        // Checks if the OS is greater that 10.0
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
        constraints()
    }
    
    
    private func constraints() {
        // Category Button
        categoryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        categoryButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        categoryButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        categoryButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
