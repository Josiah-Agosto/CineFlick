//
//  DetailViewController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController, InnerSelectedIdProtocol {
    // References
    public lazy var detailView = DetailView()
    public lazy var detailManager = DetailNetworkManager.shared
    public lazy var apiManager = APINetworkManager.shared
    public lazy var internetNetwork = InternetNetwork()
    public lazy var mainController = HomeScreenController()
    // Movie Id Delegate Property
    var movieId: String = ""
    var movieName: String = ""
    var selectedBackdropUrl: String = ""
    
    override func loadView() {
        view = detailView
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCastRequest()
        setAsynchronousImage()
        getRuntimeRequest()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        internetNetwork.checkForInternetConnectivity()
        detailView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: detailView.castCollectionView.frame.origin.y + 185)
        addMovieTitleToNavigationTitle()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        uponViewsRemoval()
    }

    
    private func addMovieTitleToNavigationTitle() {
        title = movieName
        // Title Color
        navigationController?.navigationBar.tintColor = UIColor(named: "LabelColors")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "LabelColors")!]
        let doneButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        navigationItem.backBarButtonItem = doneButtonItem
    }
    
    // MARK: - Delegate Functions
    private func fetchCastRequest() {
        let queue = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        queue.async {
            group.enter()
            self.detailManager.detailCast(self.movieId) { (result) in
                switch result {
                case .success():
                    defer { group.leave() }
                    DispatchQueue.main.async {
                        self.detailView.castCollectionView.reloadData()
                    }
                case .failure(let error):
                    NotificationController.displayError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // Runtime Delegate Function
    private func getRuntimeRequest() {
        apiManager.getRuntime(with: movieId) { (valueForId) in
            self.detailView.runtime.text = valueForId
        }
    }
    
    // MARK: - Functions
    private func uponViewsRemoval() {
        detailManager.deleteAllSavedData()
    }
    
    
    
    private func setAsynchronousImage() {
        detailView.backdropImage.asynchronouslyLoadImage(with: selectedBackdropUrl)
    }
    
    //MARK: Actions
    @objc private func doneButtonAction() {
        navigationController?.popToRootViewController(animated: true)
    }

}
