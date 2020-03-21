//
//  AboutController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 10/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class AboutView: UIView {
    // Creator Label
    public var creatorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Creator:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        return label
    }()
    // Creator
    public var creator: UILabel = {
        let label = UILabel()
        label.text = "Josiah Agosto"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        return label
    }()
    // GitHub Label
    public var githubLabel: UILabel = {
        let label = UILabel()
        label.text = "Github:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        return label
    }()
    // Github Name
    public var githubName: UILabel = {
        let label = UILabel()
        label.text = "UnknownEncrypter"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        // View
        backgroundColor = UIColor.green
        // Subviews
        addSubview(creatorLabel)
        addSubview(creator)
        addSubview(githubLabel)
        addSubview(githubName)
        constraints()
    }
    
    
    private func constraints() {
        let width = UIScreen.main.bounds.width
        // Creator Label
        creatorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        creatorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        creatorLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: width).isActive = true
        creatorLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // Creator
        creator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        creator.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        creator.widthAnchor.constraint(equalToConstant: width).isActive = true
        creator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Github Label
        githubLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        githubLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        githubLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        githubLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Github Name
        githubName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        githubName.topAnchor.constraint(equalTo: topAnchor, constant: 140).isActive = true
        githubName.widthAnchor.constraint(equalToConstant: width).isActive = true
        githubName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
