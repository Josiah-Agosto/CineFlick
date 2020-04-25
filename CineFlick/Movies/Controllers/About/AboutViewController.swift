//
//  AboutController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class AboutViewController: UIViewController {
    // MARK: - Properties / References
    private lazy var aboutView = AboutView()
    private var mainViewBarItem: MainScreenView!
    private var slideController: SlideViewController!
    private lazy var slideMenuHelper = SlideMenuHelper()
    private lazy var privacyPolicyController = PrivacyPolicyController()
    private var blurIsHidden: Bool = true
    
    override func loadView() {
        aboutView = AboutView()
        view = aboutView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        title = "The Developer"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "LabelColors")!]
        // Category Button
        barItemsSetup()
        // Blur Effect View
        blurEffectSetup()
    }
    
    // MARK: - Private Functions
    private func barItemsSetup() {
        mainViewBarItem = MainScreenView()
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundColors")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: mainViewBarItem.categoryImageView.image, style: .plain, target: self, action: #selector(categoryAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Privacy Policy", style: .plain, target: self, action: #selector(privacyPolicyAction))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue
    }
    
    
    private func blurEffectSetup() {
        aboutView.blurEffectView.effect = aboutView.blurEffect
        aboutView.blurEffectView.frame = view.bounds
        aboutView.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        aboutView.blurEffectView.isHidden = true
        aboutView.blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTap)))
        view.insertSubview(aboutView.blurEffectView, aboveSubview: view)
    }
    
    
    private func blurEffectTransition() {
        aboutView.blurEffectView.isHidden = blurIsHidden
    }

    // MARK: - Private Functions
    private func homeSlideMenuLogic() {
        slideMenuHelper.isOpen.toggle()
        slideMenuHelper.shouldExpandSlideMenu(slideMenuHelper.isOpen) { (expanded) in
            if expanded {
                self.blurIsHidden = !expanded
                self.slideMenuHelper.addSlideMenuToWindow(&self.slideController)
            } else {
                self.blurIsHidden = !expanded
                self.slideMenuHelper.removeSlideMenuToWindow(&self.slideController)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func categoryAction() {
        homeSlideMenuLogic()
        blurEffectTransition()
    }
    
    
    @objc private func blurEffectTap() {
        homeSlideMenuLogic()
        blurEffectTransition()
    }
    
    
    @objc private func privacyPolicyAction() {
        navigationController?.pushViewController(privacyPolicyController, animated: true)
    }
    
}


// MARK: - Movie Delegate Function
extension AboutViewController: ChangeToMovieControllerProtocol {
    func pushMovieToController() {
        slideController = SlideViewController()
        slideMenuHelper.isOpen.toggle()
        homeSlideMenuLogic()
        slideMenuHelper.removeSlideMenuToWindow(&slideController)
    }
}
