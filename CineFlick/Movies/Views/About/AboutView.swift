//
//  AboutView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 10/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class AboutView: UIView {
    // Creator Label
    public lazy var creatorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Creator:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = UIColor(named: "LabelColors")
        return label
    }()
    // Creator
    public lazy var creator: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Josiah Agosto"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        label.textColor = UIColor(named: "LabelColors")
        return label
    }()
    // GitHub Label
    public lazy var gitHubLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Github:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = UIColor(named: "LabelColors")
        return label
    }()
    // Github Name
    public lazy var gitHubName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "UnknownEncrypter"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        label.textColor = UIColor(named: "LabelColors")
        return label
    }()
    // Credits Logo
    public lazy var creditImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "TheMovieDBLogo")
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // Credits label
    public lazy var creditsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This product uses the TMDb API but is not endorsed or certified by TMDb.\n To learn more go to https://www.themoviedb.org/."
        label.font = UIFont(name: "Avenir-Medium", size: 13)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "LabelColors")
        label.textAlignment = .center
        return label
    }()
    public lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    public lazy var blurEffectView = UIVisualEffectView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        // View
        backgroundColor = UIColor(named: "BackgroundColors")
        // Subviews
        addSubview(creatorLabel)
        addSubview(creator)
        addSubview(gitHubLabel)
        addSubview(gitHubName)
        addSubview(creditImageView)
        addSubview(creditsLabel)
        constraints()
    }
    
    
    private func constraints() {
        // Creator Label
        creatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        creatorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        creatorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        creatorLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // Creator
        creator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        creator.topAnchor.constraint(equalTo: creatorLabel.bottomAnchor, constant: 10).isActive = true
        creator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        creator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Github Label
        gitHubLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        gitHubLabel.topAnchor.constraint(equalTo: creator.bottomAnchor, constant: 10).isActive = true
        gitHubLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        gitHubLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Github Name
        gitHubName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        gitHubName.topAnchor.constraint(equalTo: gitHubLabel.bottomAnchor, constant: 10).isActive = true
        gitHubName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        gitHubName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Credit Image View
        creditImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        creditImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -96).isActive = true
        creditImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        creditImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        // Credit Label
        creditsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        creditsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        creditsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        creditsLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
