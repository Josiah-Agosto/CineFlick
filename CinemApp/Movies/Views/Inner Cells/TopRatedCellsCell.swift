//
//  TopRatedCellsCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class TopRatedCellsView: UICollectionViewCell {
    // Title
    public var movieTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 225, width: 150, height: 50))
        // Label Text
        label.text = "Top Rated"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        return label
    }()
    // Image
    public var movieImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 225))
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    // Release Date
    public var movieRating: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 275, width: 150, height: 15))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        return label
    }()
    
    // MARK: - For Detail View
    public var backdropImage: UIImageView = {
        let backdrop = UIImageView()
        backdrop.layer.cornerRadius = 5
        backdrop.clipsToBounds = true
        backdrop.contentMode = .scaleAspectFill
        return backdrop
    }()
    public var id: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    public var overview: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    public var runtime: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    public var rating: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    public var releaseDate: UILabel = {
        let backdrop = UILabel()
        backdrop.text = ""
        return backdrop
    }()
    static let reuseIdentifier = "TopRatedCellsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.clear
        addSubview(movieTitle)
        addSubview(movieImage)
        addSubview(movieRating)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
