//
//  ErrorView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 4/1/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    // Properties
    // Label
    public lazy var errorDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    // Swipe Gesture
    public lazy var swipeUpGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer()
        gesture.direction = .up
        return gesture
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // Appearance
        backgroundColor = UIColor.black
        layer.cornerRadius = 20
        addGestureRecognizer(swipeUpGesture)
        constraints()
    }
    
    
    private func constraints() {
        // Label
        errorDescription.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        errorDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        errorDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        errorDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 125)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
