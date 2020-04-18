//
//  DetailViewController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, InnerSelectedIdProtocol {
    // References
    public lazy var detailView = DetailView()
    public var detailManager = DetailNetworkManager.shared
    public lazy var internetNetwork = InternetNetwork()
    // Movie Id Delegate Property
    var movieId: String = ""
    var movieName: String = ""
    
    override func loadView() {
        view = detailView
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        internetNetwork.checkForInternetConnectivity()
        detailView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: detailView.castCollectionView.frame.origin.y + 185)
        fetchRequest()
        addMovieTitleToNavigationTitle()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        uponViewsRemoval()
    }

    
    private func addMovieTitleToNavigationTitle() {
        title = movieName
        // Title Color
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "LabelColors")!]
    }
    
    
    private func uponViewsRemoval() {
        detailManager.deleteAllSavedData()
    }
    
    
    private func fetchRequest() {
        detailManager.detailCast(movieId) { (result) in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.detailView.castCollectionView.reloadData()
                }
            case .failure(let error):
                NotificationController.displayError(message: error.localizedDescription)
            }
        }
    }

}
