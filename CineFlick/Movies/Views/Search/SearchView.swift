//
//  SearchView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/26/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class SearchView: UIView {
    // Properties / References
    // Search Bar
    public lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.isTranslucent = true
        searchBar.showsCancelButton = true
        searchBar.showsBookmarkButton = false
        searchBar.showsScopeBar = false
        searchBar.sizeToFit()
        return searchBar
    }()
    // Table View
    public lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = SearchCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieSearchCell.self, forCellWithReuseIdentifier: MovieSearchCell.reuseIdentifier)
        collectionView.isHidden = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(named: "BackgroundColors")
        // Subviews
        addSubview(collectionView)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        // Collection View
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
