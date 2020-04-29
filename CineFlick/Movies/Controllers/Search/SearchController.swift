//
//  SearchController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/26/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

// TODO: Fix keyboard resigning
class SearchController: UIViewController {
    // References / Properties
    public lazy var searchView = SearchView()
    public lazy var searchManager = SearchManager.shared
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
    }
    
    // MARK: - Setup
    private func setup() {
        // Navigation
        navigationController?.setToolbarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        searchView.searchBar.delegate = self
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        navigationItem.titleView = searchView.searchBar
        searchView.searchBar.becomeFirstResponder()
    }
    
    
    // MARK: - Functions
    public func goBackToRootController() {
        searchView.searchBar.resignFirstResponder()
        searchView.searchBar.endEditing(true)
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    public func requestMoviesWithSearch(of type: String?) {
        guard let queryString = type else { return }
        searchManager.searchForMoviesWith(query: queryString) { (result) in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.searchView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    public func searchBarIsEmpty() {
        resetSearchData()
        searchView.collectionView.reloadData()
    }

    
    public func resetSearchData() {
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
}
