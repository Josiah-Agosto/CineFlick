//
//  HomeScreenController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class HomeScreenController: UIViewController {
    // MARK: References / Properties
    public var mainView: MainScreenView!
    public var apiManager = APINetworkManager.shared
    public lazy var detailController = DetailViewController()
    public var launchScreenController = LaunchScreenController()
    public lazy var internetNetwork = InternetNetwork(parent: self)
    private var blurEffectView = UIVisualEffectView()
    private var slideController: SlideViewController!
    private var aboutController: AboutViewController!
    private lazy var slideMenuHelper = SlideMenuHelper()
    private var blurIsHidden: Bool = true
    // Delegates
    public weak var launchScreenDelegate: LaunchScreenProtocol?
    public weak var castMovieIdDelegate: CastMovieIdProtocol?
    public weak var handleSlideMenuDelegate: HandleSlideMenuProtocol?
    // Delegate Properties
    var isCellSelected: Bool = false
    
    override func loadView() {
        mainView = MainScreenView()
        view = mainView
    }
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        internetNetwork.checkForInternetConnectivity()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if launchScreenLoaded.bool(forKey: "LaunchScreenLoaded") == false {
            initialSetup()
            setupLaunchScreen()
            makeRequestToServer()
        } else {
            initialSetup()
            leftBarButtonView()
            makeRequestToServer()
        }
    }
    
    
    private func setupLaunchScreen() {
        launchScreenDelegate = launchScreenController
        navigationController?.pushViewController(launchScreenController, animated: false)
    }
    
    // MARK: Api Function
    private func makeRequestToServer() {
        if launchScreenLoaded.bool(forKey: "LaunchScreenLoaded") == false {
            firstTimeOpeningApplicationRequest()
            launchScreenLoaded.set(true, forKey: "LaunchScreenLoaded")
        } else {
            applicationHasAlreadyLoadedLaunchScreenRequest()
        }
    }
    
    // MARK: Setup
    private func initialSetup() {
        // Navigation Controller Setup
        navigationControllerSetup()
        // Blur Effect
        blurEffectSetup()
        // Refresh Control Target
        mainView.refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
    }
    
    // MARK: Refresh Control
    @objc private func refreshView() {
        makeRequestToServer()
    }

    // MARK: Actions
    @objc private func blurEffectTap() {
        homeSlideMenuLogic()
        blurEffectTransition()
    }

    
    @objc private func categoryAction() {
        homeSlideMenuLogic()
        blurEffectTransition()
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
    
    // First time loading application request
    private func firstTimeOpeningApplicationRequest() {
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
        } // Request End
    }
    
    // Application already been open request
    private func applicationHasAlreadyLoadedLaunchScreenRequest() {
        apiManager.makeApiRequest {
            self.mainView.refreshControl.endRefreshing()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                for cell in self.mainView.collectionView.visibleCells {
                    if let cell = cell as? MovieCollectionViewCell {
                        cell.innerCollectionView.reloadData()
                    }
                }
            }
        } // Request End
    }
    
    // MARK: Setup Functions
    private func navigationControllerSetup() {
        navigationController?.isNavigationBarHidden = false
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 50)!, NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)]
    }
    
    
    private func leftBarButtonView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: mainView.categoryImageView.image, style: .plain, target: self, action: #selector(categoryAction))
    }
    
    // Assigning Blur Effect View
    private func blurEffectTransition() {
        blurEffectView.isHidden = blurIsHidden
    }
    
    
    private func blurEffectSetup() {
        blurEffectView.effect = mainView.blurEffect
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTap)))
        view.insertSubview(blurEffectView, at: 1)
    }
} // Class end


// MARK: Cell Selection Delegate Function
extension HomeScreenController: InnerSelectedCellProtocol {
    func isCellSelectedHandler() {
        if isCellSelected == true {
            DispatchQueue.main.async {
                self.slideMenuHelper.appDelegate?.navigationController?.pushViewController(self.detailController, animated: true)
            }
        }
    }
}


// MARK: About Delegate Function
extension HomeScreenController: ChangeToAboutControllerProtocol {
    func pushAboutToController() {
        slideController = SlideViewController()
        slideMenuHelper.isOpen.toggle()
        homeSlideMenuLogic()
        slideMenuHelper.removeSlideMenuToWindow(&slideController)
    }
}
