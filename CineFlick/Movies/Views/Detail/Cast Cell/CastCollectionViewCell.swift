//
//  CastCollectionViewCell.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/27/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "cell"
    // MARK: Properties
    public lazy var person: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.white
        image.layer.borderWidth = 1.5
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = 50
        return image
    }()
    public lazy var name: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.text = "Not Found"
        label.numberOfLines = 0
        label.textColor = UIColor(named: "LabelColors")
        label.textAlignment = NSTextAlignment.center
        label.sizeToFit()
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        return label
    }()
    public lazy var characterName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor(named: "LabelColors")
        label.sizeToFit()
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.text = "Not Found"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.clear
        // Subviews
        addSubview(person)
        addSubview(name)
        addSubview(characterName)
        constraints()
    }
    
    
    private func constraints() {
        // Person
        person.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.5).isActive = true
        person.topAnchor.constraint(equalTo: topAnchor).isActive = true
        person.widthAnchor.constraint(equalToConstant: 100).isActive = true
        person.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // Name
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        name.widthAnchor.constraint(equalToConstant: 115).isActive = true
        name.heightAnchor.constraint(equalToConstant: 42).isActive = true
        // Character Name
        characterName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        characterName.topAnchor.constraint(equalTo: topAnchor, constant: 142).isActive = true
        characterName.widthAnchor.constraint(equalToConstant: 115).isActive = true
        characterName.heightAnchor.constraint(equalToConstant: 38).isActive = true
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame.size.width = UIScreen.main.bounds.width
        self.frame.size.height = 180
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
