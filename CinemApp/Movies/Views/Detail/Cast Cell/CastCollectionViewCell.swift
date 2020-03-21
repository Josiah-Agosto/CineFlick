//
//  CastCollectionViewCell.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    let person: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.white
        image.layer.borderWidth = 1.5
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = 50
        return image
    }()
    let name: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "Error"
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        return label
    }()
    let characterName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.text = "Error"
        return label
    }()
    static let reuseIdentifier = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // Frames
        person.frame = CGRect(x: 12.5, y: 0, width: 100, height: 100)
        name.frame = CGRect(x: 5, y: 100, width: 115, height: 50)
        characterName.frame = CGRect(x: 5, y: 150, width: 115, height: 30)
        // View
        backgroundColor = UIColor.clear
        addSubview(person)
        addSubview(name)
        addSubview(characterName)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.width = UIScreen.main.bounds.width - 80
        self.frame.size.height = 180
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
