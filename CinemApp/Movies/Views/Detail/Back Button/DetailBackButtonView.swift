//
//  DetailBackButtonView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 3/28/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class DetailBackButtonView: UIView {
    // Properties
    public lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "arrow.left.circle.fill")!
            let imageWithColor = image.withTintColor(UIColor(red: 65/255, green: 0, blue: 0, alpha: 1.0))
            imageView.image = imageWithColor
        } else {
            imageView.image = UIImage(named: "ImageNotFound")
        }
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        addSubview(arrowImageView)
        constraints()
    }
    
    
    private func constraints() {
        // Arrow Image View
        arrowImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        arrowImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        arrowImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
