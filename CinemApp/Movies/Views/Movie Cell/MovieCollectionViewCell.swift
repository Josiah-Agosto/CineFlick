//
//  MovieCollectionViewCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/14/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    // Needed For other Properties
    public var apiManager = APINetworkManager.shared
    static let reuseIdentifier = "cell"
    // Date Formatter
    lazy var dateFormatter = DateFormatter()
    // Inner Cell
    lazy var innerCollectionView: UICollectionView = {
        let layout = InnerCollectionViewFlowLayout()
        let innerCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        innerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        innerCollectionView.showsHorizontalScrollIndicator = false
        innerCollectionView.allowsSelection = true
        innerCollectionView.backgroundColor = UIColor.clear
        return innerCollectionView
    }()
    // References
    public var movieEnum: MovieSectionEnum = .popular
    public lazy var mainController = HomeScreenController()
    public var innerCollectionDelegate: HomeScreenInnerDelegate?
    public var innerCollectionDataSource: HomeScreenInnerDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // Collection View
        innerCollectionDelegate = HomeScreenInnerDelegate(parentCell: self, withDelegate: mainController)
        innerCollectionDataSource = HomeScreenInnerDataSource(parentCell: self)
        innerCollectionView.delegate = innerCollectionDelegate
        innerCollectionView.dataSource = innerCollectionDataSource
        innerCollectionView.register(PopularMovieCellsView.self, forCellWithReuseIdentifier: PopularMovieCellsView.reuseIdentifier)
        innerCollectionView.register(NowPlayingCellsView.self, forCellWithReuseIdentifier: NowPlayingCellsView.reuseIdentifier)
        innerCollectionView.register(UpcomingCellsView.self, forCellWithReuseIdentifier: UpcomingCellsView.reuseIdentifier)
        innerCollectionView.register(TopRatedCellsView.self, forCellWithReuseIdentifier: TopRatedCellsView.reuseIdentifier)
        // Subviews
        contentView.addSubview(innerCollectionView)
        constraints()
    }
    
    
    private func constraints() {
        // Inner Collection View
        innerCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        innerCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        innerCollectionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        innerCollectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Initial Collection View Cell
        self.frame.size.width = UIScreen.main.bounds.width
        self.frame.size.height = 300
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
} // Class End


// MARK: - Collection Extension
public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
