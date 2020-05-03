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
    // Movie Language Button
    public lazy var moviesLanguageButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Movie Language:", for: .normal)
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
        addSubview(moviesLanguageButton)
        addSubview(currentLanguage)
        // Constraints
        constraints()
    }

    
    private func constraints() {
        // Language Button
        moviesLanguageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        moviesLanguageButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        moviesLanguageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -96).isActive = true
        moviesLanguageButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        // Current Label
        currentLanguage.leadingAnchor.constraint(equalTo: moviesLanguageButton.trailingAnchor).isActive = true
        currentLanguage.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        currentLanguage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        currentLanguage.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
