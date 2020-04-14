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
    // Movie Id Delegate Property
    var movieId: String = ""
    
    override func loadView() {
        view = detailView
    }

    
    override func viewDidLoad() {
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detailView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: detailView.castCollectionView.frame.origin.y + 185)
        fetchRequest()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        uponViewsRemoval()
    }

    
    private func setup() {
        // TODO: Put button in ImageView
//        let exitButton = UIBarButtonItem(image: UIImage(named: "ExitButton"), style: .done, target: self, action: #selector(exitButtonAction))
//        navigationItem.leftBarButtonItem = exitButton
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    // MARK: Actions
    @objc private func exitButtonAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    private func uponViewsRemoval() {
        detailManager.deleteAllSavedData()
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
