//
//  ContainerController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 4/3/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class ContainerController: UIViewController {
    // MARK: Properties
    private var aboutController: AboutViewController!
    private var slideController: SlideController!
    private var centerController: UINavigationController!
    private let homeController = HomeScreenController()
    // Delegates
    public weak var blurEffectBooleanDelegate: BlurEffectBooleanProtocol?
    // Slide Menu Toggle
    private var isOpen: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureHomeNavigationController()
    }
    
    
    private func setup() {
        view.backgroundColor = UIColor(red: 65/255, green: 0, blue: 0, alpha: 1.0)
    }
    
    
    private func configureHomeNavigationController() {
        homeController.handleSlideMenuDelegate = self
        self.blurEffectBooleanDelegate = homeController
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    
    private func configureAboutController() {
        aboutController = AboutViewController()
        view.insertSubview(aboutController.view, at: 0)
        addChild(aboutController)
        aboutController.didMove(toParent: self)
    }
    
    // MARK: TEST - Status: DONE
    fileprivate func addSlideMenu() {
        if slideController == nil {
            slideController = SlideController()
            view.insertSubview(slideController.view, at: 0)
            addChild(slideController)
            slideController.didMove(toParent: self)
        }
    }
    
    // MARK: TEST - Status: DONE
    fileprivate func removeSlideMenu() {
        if slideController != nil {
            slideController.view.removeFromSuperview()
            slideController.willMove(toParent: nil)
            slideController.removeFromParent()
            slideController = nil
        }
    }
    
    
    public func shouldExpandSlideMenu(_ expanded: Bool) {
        if expanded {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 100
                self.blurEffectBooleanDelegate?.blurEnabled = !expanded
                self.addSlideMenu()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                self.blurEffectBooleanDelegate?.blurEnabled = !expanded
            }, completion: { _ in
                self.removeSlideMenu()
            })
        }
    }
    
}



extension ContainerController: HandleSlideMenuProtocol {
    func handleSlideToggle() {
        isOpen = !isOpen
        shouldExpandSlideMenu(isOpen)
    }
    
}
