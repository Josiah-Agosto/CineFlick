//
//  SearchBarExtension.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            hasErrorOccurred = true
            searchBarIsEmpty()
            searchBar.showsCancelButton = true
            return
        }
        hasErrorOccurred = false
        requestMoviesWithSearch(of: searchText)
        resetSearchData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        goBackToRootController()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
}
