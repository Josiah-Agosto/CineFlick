//
//  CustomTitleView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class CustomTitleView: UIView {
    // Properties / References
    // Date Label
    public lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hi i am supposed to be a date."
        label.numberOfLines = 1
        label.textColor = UIColor(named: "TextColors")
        label.font = UIFont(name: "AvenirNext-Medium", size: 8)
        return label
    }()
    // Controller Name
    public lazy var controllerTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movies"
        label.numberOfLines = 1
        label.textColor = UIColor(named: "TextColors")
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    
    private func setup() {
        // Subviews
        addSubview(dateLabel)
        addSubview(controllerTitle)
        // Constraint
        constraints()
    }
    
    
    private func constraints() {
        // Date Label
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        // Controller Title
        controllerTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        controllerTitle.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2).isActive = true
        controllerTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        controllerTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
