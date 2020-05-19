//
//  PersonView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/3/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class PersonView: UIView {
    // Properties / References
    // Scroll View
    public lazy var containerScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor(named: "BackgroundColors")
        return scrollView
    }()
    // Profile Image
    public lazy var profilePicture: CustomImageView = {
        let image = CustomImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
        image.layer.cornerRadius = 80
        return image
    }()
    // Name Placeholder
    public lazy var personNamePlaceholder: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name:"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext", size: 15)
        return label
    }()
    // Name
    public lazy var personName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Medium", size: 23)
        label.numberOfLines = 0
        return label
    }()
    // Birthdate Placeholder
    public lazy var personBirthDatePlaceholder: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Birthdate:"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext", size: 15)
        return label
    }()
    // Birthdate
    public lazy var personBirthDate: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-Medium", size: 23)
        return label
    }()
    // Place of Birth Placeholder
    public lazy var personPlaceOfBirthPlaceholder: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BirthPlace:"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext", size: 15)
        return label
    }()
    // Place of Birth
    public lazy var personPlaceOfBirth: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-Medium", size: 23)
        return label
    }()
    // Profession Placeholder
    public lazy var personProfessionPlaceholder: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Known For:"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext", size: 15)
        return label
    }()
    // Known For; Profession
    public lazy var personProfession: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-Medium", size: 23)
        return label
    }()
    // Biography Placeholder
    public lazy var personBiographyPlaceholder: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Biography:"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext", size: 15)
        return label
    }()
    // Biography
    public lazy var personBiography: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Not Available"
        label.textColor = UIColor(named: "LabelColors")
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Medium", size: 23)
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(named: "BackgroundColors")
        addSubview(containerScrollView)
        containerScrollView.addSubview(profilePicture)
        containerScrollView.addSubview(personNamePlaceholder)
        containerScrollView.addSubview(personName)
        containerScrollView.addSubview(personBirthDatePlaceholder)
        containerScrollView.addSubview(personBirthDate)
        containerScrollView.addSubview(personPlaceOfBirthPlaceholder)
        containerScrollView.addSubview(personPlaceOfBirth)
        containerScrollView.addSubview(personProfessionPlaceholder)
        containerScrollView.addSubview(personProfession)
        containerScrollView.addSubview(personBiographyPlaceholder)
        containerScrollView.addSubview(personBiography)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        let screen = UIScreen.main.bounds
        // Container View
        containerScrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        containerScrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerScrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // Inside Container View
        // Profile Image
        profilePicture.widthAnchor.constraint(equalToConstant: screen.width / 2 - 32).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: screen.width / 2 - 32).isActive = true
        profilePicture.centerXAnchor.constraint(equalTo: containerScrollView.centerXAnchor).isActive = true
        profilePicture.topAnchor.constraint(equalTo: containerScrollView.topAnchor, constant: 10).isActive = true
        // Person Name Placeholder
        personNamePlaceholder.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 5).isActive = true
        personNamePlaceholder.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personNamePlaceholder.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        personNamePlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Person Name
        personName.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personName.topAnchor.constraint(equalTo: personNamePlaceholder.bottomAnchor, constant: 4).isActive = true
        personName.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        // Birthdate Placeholder
        personBirthDatePlaceholder.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personBirthDatePlaceholder.topAnchor.constraint(equalTo: personName.bottomAnchor, constant: 4).isActive = true
        personBirthDatePlaceholder.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        personBirthDatePlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Birthdate
        personBirthDate.topAnchor.constraint(equalTo: personBirthDatePlaceholder.bottomAnchor, constant: 4).isActive = true
        personBirthDate.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personBirthDate.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        // Place of Birth Placeholder
        personPlaceOfBirthPlaceholder.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personPlaceOfBirthPlaceholder.topAnchor.constraint(equalTo: personBirthDate.bottomAnchor, constant: 4).isActive = true
        personPlaceOfBirthPlaceholder.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        personPlaceOfBirthPlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Place of Birth
        personPlaceOfBirth.topAnchor.constraint(equalTo: personPlaceOfBirthPlaceholder.bottomAnchor, constant: 4).isActive = true
        personPlaceOfBirth.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personPlaceOfBirth.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        // Profession Placeholder
        personProfessionPlaceholder.topAnchor.constraint(equalTo: personPlaceOfBirth.bottomAnchor, constant: 4).isActive = true
        personProfessionPlaceholder.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personProfessionPlaceholder.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        personProfessionPlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Profession
        personProfession.topAnchor.constraint(equalTo: personProfessionPlaceholder.bottomAnchor, constant: 4).isActive = true
        personProfession.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personProfession.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        // Biography Placeholder
        personBiographyPlaceholder.topAnchor.constraint(equalTo: personProfession.bottomAnchor, constant: 4).isActive = true
        personBiographyPlaceholder.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personBiographyPlaceholder.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -16).isActive = true
        personBiographyPlaceholder.heightAnchor.constraint(equalToConstant: 25).isActive = true
        // Biography
        personBiography.topAnchor.constraint(equalTo: personBiographyPlaceholder.bottomAnchor, constant: 4).isActive = true
        personBiography.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor, constant: 16).isActive = true
        personBiography.widthAnchor.constraint(equalToConstant: screen.width - 32).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
