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
    let categoryTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 160))
    let movieButton = UIButton(frame: CGRect(x: 0, y: 100, width: 200, height: 125))
    let tvShowButton = UIButton(frame: CGRect(x: 0, y: 250, width: 200, height: 125))
    let popularActorsButton = UIButton(frame: CGRect(x: 0, y: 400, width: 200, height: 125))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        // View Appearance
        view.backgroundColor = UIColor(red: 65/255, green: 0, blue: 0, alpha: 1.0)
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
        tvShowButton.setTitle("TV Shows", for: .normal)
        tvShowButton.setTitleColor(UIColor.white, for: .normal)
        tvShowButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        tvShowButton.titleLabel?.textAlignment = NSTextAlignment.left
        // Popular Actors
        popularActorsButton.setTitle("Popular Actors", for: .normal)
        popularActorsButton.setTitleColor(UIColor.white, for: .normal)
        popularActorsButton.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        popularActorsButton.titleLabel?.textAlignment = NSTextAlignment.left
        // Adding to View
        view.addSubview(categoryTitle)
        view.addSubview(movieButton)
        view.addSubview(tvShowButton)
        view.addSubview(popularActorsButton)
        // Button Pressed Actions
        movieButton.addTarget(self, action: #selector(movieButtonAction(sender:)), for: .touchUpInside)
        tvShowButton.addTarget(self, action: #selector(tvShowButtonAction(sender:)), for: .touchUpInside)
        popularActorsButton.addTarget(self, action: #selector(popularActorButton(sender:)), for: .touchUpInside)
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
        tvShowButton.translatesAutoresizingMaskIntoConstraints = false
        tvShowButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 188).isActive = true
        tvShowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        // Popular Actors
        popularActorsButton.translatesAutoresizingMaskIntoConstraints = false
        popularActorsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 246).isActive = true
        popularActorsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
    }

    // Movie Button
    @objc private func movieButtonAction(sender: UIButton) {
        print("Movie Button")
    }
    
    // TV Show Button
    @objc private func tvShowButtonAction(sender: UIButton) {
        print("TV SHow Button")
    }
    
    // Actor Button
    @objc private func popularActorButton(sender: UIButton) {
        print("Popular Actor Button")
    }
}
