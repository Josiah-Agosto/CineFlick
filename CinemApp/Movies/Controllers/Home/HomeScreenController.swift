//
//  ViewController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class HomeScreenController: UIViewController, BlurEffectBooleanProtocol {
    // References / Properties
    public var apiManager = APINetworkManager.shared
    public lazy var mainView = MainScreenView()
    public lazy var detailController = DetailViewController()
    public lazy var launchScreenController = LaunchScreenController()
    public lazy var internetNetwork = InternetNetwork(parent: self)
    private var blurEffectView = UIVisualEffectView()
    // Delegates
    public weak var launchScreenDelegate: LaunchScreenProtocol?
    public weak var castMovieIdDelegate: CastMovieIdProtocol?
    public weak var handleSlideMenuDelegate: HandleSlideMenuProtocol?
    // Delegate Properties
    var blurEnabled: Bool = true
    
    override func loadView() {
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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
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
        blurEffectView.isHidden = blurEnabled
    }
    
    // MARK: - Refresh Control
    @objc private func refreshView() {
        makeRequestToServer()
    }
    
    
    private func displayingDetailController() {
        print("Back")
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    // MARK: Actions
    @objc private func blurEffectTap() {
        handleSlideMenuDelegate?.handleSlideToggle()
        blurEffectTransition()
    }

    
    @objc private func categoryAction() {
        handleSlideMenuDelegate?.handleSlideToggle()
        blurEffectTransition()
    }

    
} // Class end


// MARK: Cell Selection Extension
extension HomeScreenController: InnerSelectedCellProtocol {
    func selectedCell(isSelected: Bool) {
        if isSelected == true {
            displayingDetailController()
        }
    }
}
