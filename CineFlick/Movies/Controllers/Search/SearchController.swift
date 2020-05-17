//
//  SearchController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/26/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    // References / Properties
    public lazy var searchView = SearchView()
    public lazy var searchManager = SearchManager.shared
    private lazy var slideMenu = SlideMenuHelper()
    public lazy var searchDetailController = SearchDetailController()
    private var errorView: EmptySearchView?
    public var hasErrorOccurred: Bool = false {
        didSet {
            if hasErrorOccurred {
                errorOccurredView()
            } else {
                removeErrorView()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBackButton()
    }
    
    // MARK: - Setup
    private func setup() {
        // Navigation
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.setHidesBackButton(true, animated: false)
        searchView.searchBar.delegate = self
        searchView.collectionView.dataSource = self
        navigationItem.titleView = searchView.searchBar
        searchView.searchBar.becomeFirstResponder()
    }
    
    
    private func setupBackButton() {
        searchView.backBarButton.title = "Search"
        searchView.backBarButton.tintColor = UIColor(named: "TextColors")
        navigationItem.backBarButtonItem = searchView.backBarButton
    }
    
    // MARK: - Functions
    public func goBackToRootController() {
        searchView.searchBar.resignFirstResponder()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    public func requestMoviesWithSearch(of type: String?) {
        let queue = DispatchQueue.global(qos: .background)
        let group = DispatchGroup()
        queue.async {
            group.enter()
            guard let queryString = type else { return }
            self.searchManager.searchForMoviesWith(query: queryString) { (result) in
                switch result {
                case .success():
                    defer { group.leave() }
                    group.notify(queue: .main) {
                        self.searchView.collectionView.reloadData()
                    }
                case .failure(let error):
                    NotificationController.displayError(message: error.localizedDescription)
                }
            }
        }
    }
    
    
    public func searchBarIsEmpty() {
        resetSearchData()
        searchView.collectionView.reloadData()
    }

    
    public func resetSearchData() {
        searchManager.movieIds = []
        searchManager.movieImageUrls = []
        searchManager.movieTitles = []
    }
    
    
    public func errorOccurredView() {
        if errorView == nil {
            errorView = EmptySearchView(frame: view.bounds)
            view.addSubview(errorView ?? UIView())
            resetSearchData()
            searchView.collectionView.reloadData()
        }
    }
    
    
    public func removeErrorView() {
        if errorView != nil {
            errorView?.removeFromSuperview()
            errorView = nil
        }
    }
    
} // Class End



extension SearchController: MovieSearchProtocol {
    func didSelectMovie() {
        slideMenu.appDelegate?.navigationController?.pushViewController(searchDetailController, animated: true)
    }
}
