//
//  AboutController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    // MARK: Properties / References
    private var aboutView: AboutView!
    private var mainViewBarItem: MainScreenView!
    private lazy var blurEffectView = UIVisualEffectView()
    private var slideController: SlideViewController!
    private lazy var slideMenuHelper = SlideMenuHelper()
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
        title = "About the Developer"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        // Category Button
        leftBarButtonItemSetup()
        // Blur Effect View
        blurEffectSetup()
    }
    
    // MARK: Private Functions
    private func leftBarButtonItemSetup() {
        mainViewBarItem = MainScreenView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: mainViewBarItem.categoryImageView.image, style: .plain, target: self, action: #selector(categoryAction))
    }
    
    
    private func blurEffectSetup() {
        blurEffectView.effect = aboutView.blurEffect
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTap)))
        view.insertSubview(blurEffectView, aboveSubview: view)
    }
    
    
    private func blurEffectTransition() {
        blurEffectView.isHidden = blurIsHidden
        print(blurIsHidden)
    }
    
    // MARK: Private Functions
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
    
    // MARK: Actions
    @objc private func categoryAction() {
        homeSlideMenuLogic()
        blurEffectTransition()
    }
    
    
    @objc private func blurEffectTap() {
        homeSlideMenuLogic()
        blurEffectTransition()
    }
    
}


// MARK: Movie Delegate Function
extension AboutViewController: ChangeToMovieControllerProtocol {
    func pushMovieToController() {
        slideController = SlideViewController()
        slideMenuHelper.isOpen.toggle()
        homeSlideMenuLogic()
        slideMenuHelper.removeSlideMenuToWindow(&slideController)
    }
}
