//
//  ViewController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class HomeScreenController: UIViewController, InnerSelectedCellProtocol {
    // References / Properties
    public var mainView: MainScreenView!
    public var apiManager = APINetworkManager.shared
    public var detailController = DetailViewController()
    public var launchScreenController = LaunchScreenController()
    public lazy var internetNetwork = InternetNetwork(parent: self)
    private var blurEffectView = UIVisualEffectView()
    private var slideController: SlideController!
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private var isOpen: Bool = false
    // Delegates
    public weak var launchScreenDelegate: LaunchScreenProtocol?
    public weak var castMovieIdDelegate: CastMovieIdProtocol?
    public weak var handleSlideMenuDelegate: HandleSlideMenuProtocol?
    // Delegate Properties
    private var blurIsHidden: Bool = true
    var isCellSelected: Bool = false
    
    override func loadView() {
        mainView = MainScreenView()
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        internetNetwork.checkForInternetConnectivity()
        initialSetup()
        makeApiCall()
    }
    
    
    private func makeApiCall() {
        launchScreenDelegate = launchScreenController
        navigationController?.pushViewController(launchScreenController, animated: false)
        makeRequestToServer()
    }
    
    
    private func makeRequestToServer() {
        apiManager.makeApiRequest {
            self.leftBarButtonView()
            self.mainView.refreshControl.endRefreshing()
            self.launchScreenDelegate?.isLoadingFinished(true)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                for cell in self.mainView.collectionView.visibleCells {
                    if let cell = cell as? MovieCollectionViewCell {
                        cell.innerCollectionView.reloadData()
                    }
                }
            }
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
        view.insertSubview(blurEffectView, at: 1)
        // Refresh Control
        mainView.refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
    }
    
    
    private func leftBarButtonView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: mainView.categoryImageView.image, style: .plain, target: self, action: #selector(categoryAction))
    }
    
    
    private func blurEffectTransition() {
        blurEffectView.isHidden = blurIsHidden
    }
    
    // MARK: - Refresh Control
    @objc private func refreshView() {
        makeRequestToServer()
    }
    
    // MARK: Slide Menu Functions
    // Add Slide Menu
    private func addSlideMenuToWindow() {
        if slideController == nil {
            let window = appDelegate?.window
            guard let newWindow = window else { return }
            slideController = SlideController()
            slideController.view.tag = 1
            slideController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height)
            newWindow.addSubview(slideController.view)
        }
    }
    
    // Remove Slide Menu
    private func removeSlideMenuToWindow() {
        if slideController != nil {
            let window = appDelegate?.window
            guard let newWindow = window else { return }
            newWindow.viewWithTag(1)?.removeFromSuperview()
            slideController = nil
        }
    }

    // MARK: Actions
    @objc private func blurEffectTap() {
        shouldExpandSlideMenu(!isOpen)
        blurEffectTransition()
    }

    
    @objc private func categoryAction() {
        isOpen = !isOpen
        shouldExpandSlideMenu(isOpen)
        blurEffectTransition()
    }
    
    // MARK: Slide Menu ShouldExpand
    private func shouldExpandSlideMenu(_ expanded: Bool) {
        if expanded {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                let screenWidth = UIScreen.main.bounds.width
                self.navigationController?.view.frame.origin.x = screenWidth - 100
                self.blurIsHidden = !expanded
                self.addSlideMenuToWindow()
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.navigationController?.view.frame.origin.x = 0
                self.blurIsHidden = !expanded
                self.removeSlideMenuToWindow()
            }, completion: nil)
        }
    }

    // MARK: Cell Selection Delegate
    func isCellSelectedHandler() {
        if isCellSelected == true {
            DispatchQueue.main.async {
                self.appDelegate?.navigationController?.pushViewController(self.detailController, animated: true)
            }
        }
    }
} // Class end
