//
//  HomeScreenController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

final class HomeScreenController: UIViewController {
    // MARK: - References / Properties
    public lazy var mainView = MainScreenView()
    public lazy var detailController = DetailViewController()
    public lazy var launchScreenController = LaunchScreenController()
    public lazy var apiManager = APINetworkManager.shared
    public lazy var internetNetwork = InternetNetwork()
    private var slideController: SlideViewController!
    private lazy var slideMenuHelper = SlideMenuHelper()
    private var blurIsHidden: Bool = true
    // Delegate Properties
    var isCellSelected: Bool = false
    
    override func loadView() {
        view = mainView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        internetNetwork.checkForInternetConnectivity()
        if Constants.launchScreenLoaded.bool(forKey: "LaunchScreenLoaded") == false {
            displayLaunchScreen()
            initialSetup()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        internetNetwork.checkForInternetConnectivity()
        if Constants.launchScreenLoaded.bool(forKey: "LaunchScreenLoaded") == true {
            initialSetup()
            leftBarButtonView()
        }
    }

    // MARK: - Setup
    private func initialSetup() {
        // Navigation Controller Setup
        navigationControllerSetup()
        // Blur Effect
        blurEffectSetup()
        // Refresh Control Target
        mainView.refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
    }
    
    // MARK: - Actions
    @objc private func refreshView() {
        makeRequestToServer()
    }
    
    
    @objc private func blurEffectTap() {
        homeSlideMenuLogic()
        blurEffectTransition()
    }

    
    @objc private func categoryAction() {
        homeSlideMenuLogic()
        blurEffectTransition()
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
    
    // MARK: - Setup Functions
    private func navigationControllerSetup() {
        navigationController?.isNavigationBarHidden = false
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "LabelColors")!]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "LabelColors")!]
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
    }
    
    
    private func makeRequestToServer() {
        apiManager.resetAllElements()
        apiManager.makeApiRequest { (result) in
            switch result {
            case .success():
                self.requestForRefreshControl()
            case .failure(let error):
                NotificationController.displayError(message: error.localizedDescription)
            }
        }
    }
    
    
    private func requestForRefreshControl() {
        for cell in self.mainView.collectionView.visibleCells {
            if let cell = cell as? MovieCollectionViewCell {
                DispatchQueue.main.async {
                    cell.innerCollectionView.reloadData()
                }
            }
        }
        self.mainView.refreshControl.endRefreshing()
    }
    
    
    private func displayLaunchScreen() {
        navigationController?.pushViewController(launchScreenController, animated: false)
        navigationController?.setViewControllers([launchScreenController], animated: false)
    }
    
    
    private func leftBarButtonView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: mainView.categoryImageView.image, style: .plain, target: self, action: #selector(categoryAction))
    }
    
    // Assigning Blur Effect View
    private func blurEffectTransition() {
        mainView.blurEffectView.isHidden = blurIsHidden
    }
    
    
    private func blurEffectSetup() {
        mainView.blurEffectView.effect = mainView.blurEffect
        mainView.blurEffectView.frame = view.bounds
        mainView.blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.blurEffectView.isHidden = true
        mainView.blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTap)))
        view.insertSubview(mainView.blurEffectView, at: 1)
    }
    
} // Class end


// MARK: - API Setup
extension HomeScreenController: LaunchScreenProtocol {
    func isLoadingFinished(_ dataLoaded: Bool) {
        if dataLoaded == true {
            self.mainView.refreshControl.endRefreshing()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                for cell in self.mainView.collectionView.visibleCells {
                    if let cell = cell as? MovieCollectionViewCell {
                        cell.innerCollectionView.reloadData()
                    }
                }
            }
        } // dataLoaded End
    } // Func End
}


// MARK: - Cell Selection Delegate Function
extension HomeScreenController: InnerSelectedCellProtocol {
    func isCellSelectedHandler() {
        if isCellSelected == true {
            slideMenuHelper.appDelegate?.navigationController?.pushViewController(detailController, animated: true)
        }
    }
}


// MARK: - About Delegate Function
extension HomeScreenController: ChangeToAboutControllerProtocol {
    func pushAboutToController() {
        slideController = SlideViewController()
        slideMenuHelper.isOpen.toggle()
        homeSlideMenuLogic()
        slideMenuHelper.removeSlideMenuToWindow(&slideController)
    }
}
