//
//  LanguageCell.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {
    // Properties / References
    static let reuseIdentifier = "languageCell"
    public var languageEnum: LanguagesEnum = .English
    public var regionEnum: RegionsEnum = .English
    // Container View
    public lazy var propertyContainer: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.borderColor = UIColor(named: "TextColors")?.cgColor
        container.layer.borderWidth = 0.1
        container.layer.cornerRadius = 8
        container.backgroundColor = UIColor(named: "LanguageCellContrast")
        return container
    }()
    // English Language Name
    public lazy var englishLanguageName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Bold", size: 20)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(named: "TextColors")
        label.textAlignment = .left
        label.text = ""
        return label
    }()
    // Native Language Name
    public lazy var nativeLanguageName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AvenirNext", size: 13)
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.textColor = UIColor(named: "TextColors")
        label.text = ""
        return label
    }()
    // Language Code
    public lazy var languageCode: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "TextColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor.clear
        // Subviews
        addSubview(propertyContainer)
        propertyContainer.addSubview(englishLanguageName)
        propertyContainer.addSubview(nativeLanguageName)
        propertyContainer.addSubview(languageCode)
        // Constraints
        containerConstraints()
        constraints()
    }
    
    
    private func containerConstraints() {
        propertyContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        propertyContainer.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        propertyContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        propertyContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    
    private func constraints() {
        // English Label
        englishLanguageName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        englishLanguageName.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        englishLanguageName.trailingAnchor.constraint(equalTo: languageCode.leadingAnchor).isActive = true
        englishLanguageName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Native Label
        nativeLanguageName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nativeLanguageName.topAnchor.constraint(equalTo: englishLanguageName.bottomAnchor).isActive = true
        nativeLanguageName.trailingAnchor.constraint(equalTo: languageCode.leadingAnchor).isActive = true
        nativeLanguageName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        // Code Label
        languageCode.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60).isActive = true
        languageCode.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        languageCode.topAnchor.constraint(equalTo: topAnchor).isActive = true
        languageCode.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
