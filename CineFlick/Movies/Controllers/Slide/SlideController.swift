//
//  SlideController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 3/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

final class SlideViewController: UIViewController {
    // Properties
    public lazy var slideView = SlideView()
    private lazy var homeController = HomeScreenController()
    private lazy var aboutController = AboutViewController()
    private lazy var slideMenuHelper = SlideMenuHelper()
    private lazy var languageController = LanguageController()
    // Delegate
    public weak var changeToAboutControllerDelegate: ChangeToAboutControllerProtocol?
    public weak var changeToMovieControllerDelegate: ChangeToMovieControllerProtocol?
    public weak var changeToLanguageControllerDelegate: ChangeToLanguageControllerProtocol?
    
    override func loadView() {
        view = slideView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Functions
    private func setup() {
        slideView.movieButton.addTarget(self, action: #selector(movieButtonAction), for: .touchUpInside)
        slideView.aboutButton.addTarget(self, action: #selector(aboutButtonAction), for: .touchUpInside)
        slideView.languageContainer.moviesLanguageButton.addTarget(self, action: #selector(goToLanguageController), for: .touchUpInside)
        // Delegates
        // Home
        self.changeToAboutControllerDelegate = homeController
        // About
        self.changeToMovieControllerDelegate = aboutController
        // Language
        self.changeToLanguageControllerDelegate = languageController
    }
    
    // MARK: - Button Actions
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
    
    
    @objc private func goToLanguageController() {
        changeToLanguageControllerDelegate?.pushLanguagesToController()
        let languageNavigationController = UINavigationController(rootViewController: languageController)
        if #available(iOS 13.0, *) {
            languageNavigationController.isModalInPresentation = true
        } else {
        }
        slideMenuHelper.appDelegate?.navigationController?.present(languageNavigationController, animated: true, completion: nil)
    }

}


// MARK: - Region Updater
extension SlideViewController: LanguageViewUpdaterProtocol {
    var currentCountryCode: String {
        get {
            return ""
        }
        set {
            slideView.languageContainer.currentLanguage.text = newValue
        }
    }
    
}
