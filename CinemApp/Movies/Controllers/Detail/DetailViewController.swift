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
    public lazy var detailManager = DetailNetworkManager.shared
    private weak var homeController: HomeScreenController?
    // Movie Id Delegate Property
    var movieId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchRequest()
    }
        
    
    override func loadView() {
        view = detailView
    }
    
    
    private func setup() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: detailView.closeButton)
        navigationController?.navigationBar.addSubview(detailView.closeButton)
    }
    
    
    @objc private func closeCurrentViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    private func fetchRequest() {
        detailManager.detailCast(movieId) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.detailView.castCollectionView.reloadData()
            }
        }
    }

}
