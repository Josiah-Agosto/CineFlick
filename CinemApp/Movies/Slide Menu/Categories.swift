//
//  Categories.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/11/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class Categories: UIViewController {
    // Buttons, Labels, etc.
    let categoryTitle = UILabel()
    let movieButton = UIButton()
    let settingsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        // View Appearance
        view.backgroundColor = UIColor(red: 65/255, green: 0, blue: 0, alpha: 1.0)
        categoryTitle.frame = CGRect(x: 0, y: 35, width: view.frame.width, height: 160)
        movieButton.frame = CGRect(x: 0, y: 205, width: view.frame.width, height: 125)
        settingsButton.frame = CGRect(x: 0, y: 340, width: view.frame.width, height: 125)
        // Category
        categoryTitle.text = "Categories"
        categoryTitle.textColor = UIColor.white
        categoryTitle.textAlignment = NSTextAlignment.left
        categoryTitle.font = UIFont(name: "AvenirNext-DemiBold", size: 32)
        // Movie
        movieButton.setTitle("Movies", for: .normal)
        movieButton.setTitleColor(UIColor.white, for: .normal)
        movieButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        movieButton.titleLabel?.textAlignment = NSTextAlignment.left
        // TV Show
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.setTitleColor(UIColor.white, for: .normal)
        settingsButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        settingsButton.titleLabel?.textAlignment = NSTextAlignment.left
        // Adding to View
        view.addSubview(categoryTitle)
        view.addSubview(movieButton)
        view.addSubview(settingsButton)
        // Button Pressed Actions
        movieButton.addTarget(self, action: #selector(movieButtonAction(sender:)), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonAction(sender:)), for: .touchUpInside)
        // Configuring the Constraints
        configureConstraints()
    }
    
    // Constraints
    private func configureConstraints() {
        // Category
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        categoryTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        // Movies
        movieButton.translatesAutoresizingMaskIntoConstraints = false
        movieButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
        movieButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        // TV Shows
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 188).isActive = true
        settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
    }

    // Movie Button
    @objc private func movieButtonAction(sender: UIButton) {
        print("Movie Button")
    }
    
    // TV Show Button
    @objc private func settingsButtonAction(sender: UIButton) {
        print("Settings")
    }
    
}
