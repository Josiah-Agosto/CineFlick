//
//  UpcomingCellsCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class UpcomingCellsCell: UICollectionViewCell {
    // Title
    let movieTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 225, width: 150, height: 50))
        label.text = "Upcoming"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 17)
        return label
    }()
    // Image
    let movieImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 225))
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFill
        return image
    }()
    // Release Date
    let movieReleaseTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 275, width: 150, height: 15))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.white
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.clear
        addSubview(movieTitle)
        addSubview(movieImage)
        addSubview(movieReleaseTitle)
        print("Inside the cells Cell")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
