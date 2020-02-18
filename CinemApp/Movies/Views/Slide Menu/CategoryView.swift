//
//  CategoryView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/11/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    // Buttons, Labels, etc.
    // Title
    public var categoryTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Categories"
        title.textColor = UIColor.white
        title.textAlignment = NSTextAlignment.left
        title.font = UIFont(name: "AvenirNext-DemiBold", size: 32)
        return title
    }()
    // Movie Button
    public var movieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movies", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        button.titleLabel?.textAlignment = NSTextAlignment.left
        return button
    }()
    // About Button
    public var aboutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 18)
        button.titleLabel?.textAlignment = NSTextAlignment.left
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // View
        backgroundColor = UIColor(red: 65/255, green: 0, blue: 0, alpha: 1.0)
        // Adding to View
        addSubview(categoryTitle)
        addSubview(movieButton)
        addSubview(aboutButton)
        // Configuring the Constraints
        configureConstraints()
    }
    
    // MARK: Functions
    func slideOutCategoriesView(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.origin.x = self.frame.width - 75
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame.origin.x = 0
            }, completion: nil)
        }
    }
    
    // MARK: - Constraints
    private func configureConstraints() {
        // Category
        categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        categoryTitle.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        categoryTitle.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        categoryTitle.heightAnchor.constraint(equalToConstant: 160).isActive = true
        // Movies
        movieButton.topAnchor.constraint(equalTo: topAnchor, constant: 205).isActive = true
        movieButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        movieButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        movieButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
        // About
        aboutButton.topAnchor.constraint(equalTo: topAnchor, constant: 340).isActive = true
        aboutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        aboutButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        aboutButton.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
