//
//  LaunchScreenView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 3/16/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class LaunchScreenView: UIView {
    // Views
    private lazy var imageViewLogo: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Closed Clapboard")
        return imageView
    }()
    public lazy var dataActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect.zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(red: 65 / 255, green: 0, blue: 0, alpha: 1.0)
        // Activity Indicator
        dataActivityIndicator.style = .whiteLarge
        // Subviews
        addSubview(imageViewLogo)
        addSubview(dataActivityIndicator)
        constraints()
    }
    
    
    private func constraints() {
        // Image View
        imageViewLogo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageViewLogo.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        imageViewLogo.widthAnchor.constraint(equalToConstant: 175).isActive = true
        imageViewLogo.heightAnchor.constraint(equalToConstant: 120).isActive = true
        // Activity Indicator
        dataActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dataActivityIndicator.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 50).isActive = true
        dataActivityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dataActivityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
