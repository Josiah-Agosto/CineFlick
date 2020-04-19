//
//  SlideController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 3/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {
    // Properties
    public lazy var slideView = CategoryView()
    private lazy var homeController = HomeScreenController()
    private lazy var aboutController = AboutViewController()
    private lazy var slideMenuHelper = SlideMenuHelper()
    // Delegate
    public weak var changeToAboutControllerDelegate: ChangeToAboutControllerProtocol?
    public weak var changeToMovieControllerDelegate: ChangeToMovieControllerProtocol?
    
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
        // Delegates
        // Home Controller Assigning
        self.changeToAboutControllerDelegate = homeController
        // About Controller Assigning
        self.changeToMovieControllerDelegate = aboutController
    }
    
    // MARK: Button Actions
    @objc private func movieButtonAction() {
        changeToMovieControllerDelegate?.pushMovieToController()
        if slideMenuHelper.appDelegate?.navigationController?.viewControllers.first != homeController {
            slideMenuHelper.appDelegate?.navigationController?.pushViewController(homeController, animated: false)
            slideMenuHelper.appDelegate?.navigationController?.setViewControllers([homeController], animated: false)
        }
    }
    
    
    @objc private func aboutButtonAction() {
        changeToAboutControllerDelegate?.pushAboutToController()
        if slideMenuHelper.appDelegate?.navigationController?.viewControllers.first != aboutController {
            slideMenuHelper.appDelegate?.navigationController?.pushViewController(aboutController, animated: false)
            slideMenuHelper.appDelegate?.navigationController?.setViewControllers([aboutController], animated: false)
        }
    }

}
