//
//  ViewController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class HomeScreenController: UIViewController {
    // Variables and Constants
    private var isOpen: Bool = false
    // References
    public let apiManager = APINetworkManager()
    public var mainView: MainScreenView!
    public var categoryView: CategoryView!
    var delegatePropertyProtocol: HomeScreenPropertiesProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        makeApiCall()
    }
    
    
    private func makeApiCall() {
        apiManager.makeApiRequest {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                for cell in self.mainView.collectionView.visibleCells {
                    if let cell = cell as? MovieCollectionViewCell {
                        cell.innerCollectionView.reloadData()
                    }
                }
            }
            self.mainView.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Setup
    func initialSetup() {
        // View
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.categoryButton)
        navigationController?.navigationBar.addSubview(mainView.categoryButton)
        navigationController?.navigationBar.topItem?.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 50)!, NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)]
        // Collection View Protocols
        delegatePropertyProtocol.mainView = MainScreenView()
        let collectionViewDelegate = HomeScreenDelegate()
        let collectionViewDataSource = HomeScreenDataSource()
        mainView.collectionView.delegate = collectionViewDelegate
        mainView.collectionView.dataSource = collectionViewDataSource
    }
    
    // MARK: - Refresh Control
    @objc private func refreshView(_ sender: Any) {
        makeApiCall()
    }
    
    // MARK: - Slide Menu
    @objc private func categoryAction(sender: UIBarButtonItem) {
        // When the Category button is pressed
        handleSlideToggle()
    }
    
    // Slide Menu Effects
    private func slideOutCategoriesView(shouldExpand: Bool) {
        guard let window = UIApplication.shared.keyWindow else { return }
        // Adding Blur Effect in background
        let blurEffectView = UIVisualEffectView(effect: mainView.blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        categoryView = CategoryView()
        window.addSubview(categoryView)
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTap)))
        // Starting point
        categoryView.frame = CGRect(x: -window.frame.width - 90, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
        if shouldExpand {
            // Category Button Animation
            mainView = MainScreenView()
            UIView.animate(withDuration: 0.2) {
                if self.isOpen == true {
                    self.mainView.categoryButton.transform = CGAffineTransform(rotationAngle: 30)
                }
            }
            // Pop-In of Category View
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.categoryView.frame = CGRect(x: 0, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
                self.view.addSubview(blurEffectView)
            }, completion: nil)
        } else {
            dismissSlideMenu()
        } // Else End
    } // Func End
    
    
    func dismissSlideMenu() {
        guard let window = UIApplication.shared.keyWindow else { return }
        self.isOpen = false
        // Hides the Category View
        UIView.animate(withDuration: 0.9, animations: {
            self.categoryView.frame = CGRect(x: -window.frame.width - 90, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
            // Category Button Animations
            UIView.animate(withDuration: 0.6) {
                // Removes the Blur Effect
                for subview in self.view.subviews {
                    if subview is UIVisualEffectView {
                        subview.removeFromSuperview()
                    }
                }
            }
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                if self.isOpen == false {
                    self.mainView.categoryButton.transform = CGAffineTransform(rotationAngle: 0)
                }
            })
        })
    }
    
    
    @objc private func blurEffectTap() {
        UIView.animate(withDuration: 0.6) {
            self.slideOutCategoriesView(shouldExpand: !self.isOpen)
        }
    }
    
    
    private func handleSlideToggle() {
        isOpen = !isOpen
        slideOutCategoriesView(shouldExpand: isOpen)
    }
    

    func moviePush(_ sender: UIButton, completion: @escaping () -> Void) -> Void {
        navigationController?.popToRootViewController(animated: true)
        completion()
    }
    
    
    func aboutPush(_ sender: UIButton, completion: @escaping () -> Void) -> Void {
        let about = AboutController()
        navigationController?.present(about, animated: true, completion: nil)
        completion()
    }
} // Class end

