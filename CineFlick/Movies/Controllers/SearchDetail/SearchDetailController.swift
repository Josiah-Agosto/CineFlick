//
//  SearchDetailController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/4/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

final class SearchDetailController: UIViewController, searchMovieIdProtocol {
    // References / Properties
    public lazy var searchDetailView = SearchDetailView()
    public lazy var detailManager = DetailNetworkManager.shared
    public lazy var configurationManager = ConfigurationManager.shared
    var movieId: String = ""

    override func loadView() {
        super.loadView()
        view = searchDetailView
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieRequest()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchDetailView.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: searchDetailView.overview.frame.origin.y + searchDetailView.overview.frame.size.height + 5)
    }
    
    
    private func movieRequest() {
        requestMovieDetail()
    }
    
    // MARK: - Private Functions
    public func requestMovieDetail() {
        detailManager.movieDetail(with: movieId) { (result) in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.searchDetailView.overview.text = self.detailManager.overview
                    self.searchDetailView.releaseDate.text = self.detailManager.releaseDate
                    self.requestBackdropImage(with: self.detailManager.backdropPath)
                }
            case .failure(let error):
                NotificationController.displayError(message: error.localizedDescription)
            }
        }
    }
    
    
    private func requestBackdropImage(with backdropPath: String) {
        configurationManager.fetchImages()
        let imagePath = "\(configurationManager.secureBaseUrl)\(configurationManager.backdropSize)\(backdropPath)"
        print(imagePath)
        searchDetailView.backdropImage.asynchronouslyLoadImage(with: imagePath)
    }

}
