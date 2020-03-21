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
    private lazy var about = AboutViewController()
    
    override func loadView() {
        view = slideView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.isNavigationBarHidden = false
        // Actions
        slideView.movieButton.addTarget(self.navigationController, action: #selector(movieButtonAction), for: .touchUpInside)
        slideView.aboutButton.addTarget(self.navigationController, action: #selector(aboutButtonAction), for: .touchUpInside)
    }
    
    
    @objc private func movieButtonAction() {
        print("Movie")
    }
    
    
    @objc private func aboutButtonAction() {
        print("About")
    }

}
