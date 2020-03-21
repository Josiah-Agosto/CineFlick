//
//  ViewController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class HomeScreenController: UIViewController, InnerCellPropertyProtocol {
    // References / Properties
    public var apiManager = APINetworkManager.shared
    public lazy var mainView = MainScreenView()
    public lazy var detailController = DetailViewController()
    public lazy var launchScreenController = LaunchScreenController()
    public lazy var launchScreenView = LaunchScreenView()
    public var slideController = SlideController()
    private var blurEffectView = UIVisualEffectView()
    private var isOpen: Bool = false
    // Launch Screen Delegate
    public weak var launchScreenDelegate: LaunchScreenProtocol?
    // Detail View Delegate
    var movieId: String = ""
    
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        makeApiCall()
    }
    
    
    private func makeApiCall() {
        launchScreenDelegate = launchScreenController
        navigationController?.pushViewController(launchScreenController, animated: false)
        apiManager.makeApiRequest {
            self.launchScreenDelegate?.isLoadingFinished(true)
            self.setupAfterLoading()
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
    private func initialSetup() {
        // Navigation Controller
        navigationController?.isNavigationBarHidden = false
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationController?.navigationBar.topItem?.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 50)!, NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)]
        // Blur Effect
        blurEffectView.effect = mainView.blurEffect
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTap)))
        view.addSubview(blurEffectView)
    }
    
    
    private func setupAfterLoading() {
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.categoryButton)
        navigationController?.navigationBar.addSubview(mainView.categoryButton)
        mainView.categoryButton.addTarget(self, action: #selector(categoryAction), for: .touchUpInside)
    }
    
    // MARK: - Refresh Control
    @objc private func refreshView(_ sender: Any) {
        makeApiCall()
    }
    
    // MARK: Delegate Function
    func selectedCell(isSelected: Bool) {
        if isSelected == true {
            pushToDetailController()
        }
    }
    
    // MARK: Actions
    @objc private func blurEffectTap() {
        shouldExpandSlideMenu(false)
    }
    
    // MARK: TEST - Status: Undone
    private func addChildViewController(from slideController: SlideController) {
        slideController.view.frame = UIScreen.main.bounds
        self.navigationController?.view.insertSubview(slideController.view, at: 0)
        self.navigationController?.addChild(slideController)
        slideController.didMove(toParent: self.navigationController)
        animateController(state: true, completion: nil)
    }
    
    // MARK: TEST - Status: Undone
    private func removeSlideController() {
        animateController(state: false) { (_) in
            self.slideController.view.removeFromSuperview()
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    
    public func shouldExpandSlideMenu(_ expanded: Bool) {
        if expanded {
            addChildViewController(from: slideController)
        } else {
            removeSlideController()
        }
    }
    // MARK: TEST - Status: Undone
    /// True is Open, False is Closed
    private func animateController(state of: Bool, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            switch of {
            case true:
                self.view.frame.origin.x = UIScreen.main.bounds.width - 100
                self.navigationController?.navigationBar.isHidden = true
                self.blurEffectView.isHidden = false
            case false:
                self.view.frame.origin.x = 0
                self.blurEffectView.isHidden = true
            }
        }, completion: completion)
    }
    
    private func pushToDetailController() {
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    
    @objc private func categoryAction() {
        isOpen = !isOpen
        shouldExpandSlideMenu(isOpen)
    }
    
} // Class end
