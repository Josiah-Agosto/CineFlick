//
//  LaunchScreenController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 3/16/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

final class LaunchScreenController: UIViewController {
    // Properties
    public lazy var launchView = LaunchScreenView()
    private lazy var homeController = HomeScreenController()
    private lazy var internetNetwork = InternetNetwork()
    private var apiManager = APINetworkManager.shared
    // Delegates
    public weak var launchScreenDelegate: LaunchScreenProtocol?
        
    override func loadView() {
        super.loadView()
        view = launchView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        internetNetwork.checkForInternetConnectivity()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        apiLoader()
    }
    
    // MARK: - Private Functions
    private func setup() {
        // Delegate
        self.launchScreenDelegate = homeController
        // View
        navigationItem.hidesBackButton = true
        launchView.dataActivityIndicator.startAnimating()
    }

    // MARK: - API Loading
    private func apiLoader() {
        apiManager.makeApiRequest { (result) in
            switch result {
            case .success():
                self.launchScreenDelegate?.isLoadingFinished(true)
                self.moveBackToHomeController()
                Constants.launchScreenLoaded.set(true, forKey: "LaunchScreenLoaded")
            case .failure(let error):
                NotificationController.displayError(message: error.localizedDescription)
            }
        }
    }
    
    
    private func moveBackToHomeController() {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(self.homeController, animated: false)
            self.navigationController?.setViewControllers([self.homeController], animated: false)
        }
    }
    
}
