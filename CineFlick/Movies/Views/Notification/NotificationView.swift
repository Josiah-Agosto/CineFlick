//
//  NotificationView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/1/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    // Title
    public lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "LabelColors")
        label.font = UIFont(name: "Avenir-Medium", size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        bannerSetup()
        addSubview(errorLabel)
        constraints()
    }
    
    
    private func bannerSetup() {
        // Banner View
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 30
        backgroundColor = UIColor.red
    }
    
    
    private func constraints() {
        // Error Label
        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        errorLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -30).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
