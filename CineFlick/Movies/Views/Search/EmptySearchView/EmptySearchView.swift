//
//  EmptySearchView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/28/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class EmptySearchView: UIView {
    // Properties / References
    public lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your search did not have any results."
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(named: "BackgroundColors")
        // Subview
        addSubview(errorLabel)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        // Error Label
        errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        errorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
