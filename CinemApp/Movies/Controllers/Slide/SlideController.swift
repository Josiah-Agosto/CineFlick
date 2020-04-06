//
//  SlideController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 3/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class SlideController: UIViewController {
    // Properties
    public lazy var slideView = CategoryView()
    
    override func loadView() {
        view = slideView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        slideView.movieButton.addTarget(self, action: #selector(movieButtonAction), for: .touchUpInside)
        slideView.aboutButton.addTarget(self, action: #selector(aboutButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func movieButtonAction() {
        print("Movie")
    }
    
    
    @objc private func aboutButtonAction() {
        print("About")
    }

}
