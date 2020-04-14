//
//  AboutController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 10/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

// TODO: Add Credits for MovieDatabase Label
class AboutView: UIView {
    // Creator Label
    public lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Creator:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = UIColor.white
        return label
    }()
    // Creator
    public lazy var creator: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Josiah Agosto"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        label.textColor = UIColor.white
        return label
    }()
    // GitHub Label
    public lazy var gitHubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Github:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.textColor = UIColor.white
        return label
    }()
    // Github Name
    public lazy var gitHubName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "UnknownEncrypter"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        label.textColor = UIColor.white
        return label
    }()
    public lazy var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        // View
        backgroundColor = UIColor(red: 41 / 255, green: 42 / 255, blue: 47 / 255, alpha: 1.0)
        // Subviews
        addSubview(creatorLabel)
        addSubview(creator)
        addSubview(gitHubLabel)
        addSubview(gitHubName)
        constraints()
    }
    
    
    private func constraints() {
        let width = UIScreen.main.bounds.width
        // Creator Label
        creatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        creatorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 95).isActive = true
        creatorLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: width).isActive = true
        creatorLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // Creator
        creator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        creator.topAnchor.constraint(equalTo: topAnchor, constant: 140).isActive = true
        creator.widthAnchor.constraint(equalToConstant: width).isActive = true
        creator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Github Label
        gitHubLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        gitHubLabel.topAnchor.constraint(equalTo: topAnchor, constant: 180).isActive = true
        gitHubLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        gitHubLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Github Name
        gitHubName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        gitHubName.topAnchor.constraint(equalTo: topAnchor, constant: 220).isActive = true
        gitHubName.widthAnchor.constraint(equalToConstant: width).isActive = true
        gitHubName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
