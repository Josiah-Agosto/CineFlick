//
//  TopRatedCellsCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class TopRatedCellsCell: UICollectionViewCell {
    // Title
    let movieTitle: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
        label.text = "Hello"
        return label
    }()
    // Image
    let movieImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
        return image
    }()
    // Release Date
    let movieRating: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
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
        addSubview(movieRating)
        print("Inside the cells Cell")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
