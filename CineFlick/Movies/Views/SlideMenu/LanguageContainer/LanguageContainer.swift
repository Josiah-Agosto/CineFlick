//
//  languageContainer.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/29/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class LanguageContainer: UIView {
    // Properties / References
    // Language Image View
    public lazy var languageImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            let movieImage = UIImage(systemName: "globe")!
            let movieImageWithColor = movieImage.withTintColor(UIColor(named: "LabelColors")!, renderingMode: .alwaysOriginal)
            imageView.image = movieImageWithColor
        } else {
            imageView.image = UIImage(named: "Globe")
        }
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    // Movie Language Button
    public lazy var moviesLanguageButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movie Language:", for: .normal)
        button.setTitleColor(UIColor(named: "TextColors"), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    // Current Language Label
    public lazy var currentLanguage: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = Constants.selectedRegion.rawValue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // Subviews
        addSubview(languageImageView)
        addSubview(moviesLanguageButton)
        addSubview(currentLanguage)
        // Constraints
        constraints()
    }

    
    private func constraints() {
        // Language Image View
        languageImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        languageImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        languageImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        languageImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Language Button
        moviesLanguageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        moviesLanguageButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        moviesLanguageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -76).isActive = true
        moviesLanguageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Current Label
        currentLanguage.leadingAnchor.constraint(equalTo: moviesLanguageButton.trailingAnchor).isActive = true
        currentLanguage.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        currentLanguage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        currentLanguage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
