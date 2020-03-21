//
//  HomeScreenDataSource.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class HomeScreenMainDataSource: NSObject, UICollectionViewDataSource {
    private var mainController: HomeScreenController!
    
    init(homeController: HomeScreenController) {
        self.mainController = homeController
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor.clear
        if indexPath.section == 0 {
            cell.movieEnum = .popular
            cell.apiManager = mainController.apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
            }
        } else if indexPath.section == 1 {
            cell.movieEnum = .nowPlaying
            cell.apiManager = mainController.apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
            }
        } else if indexPath.section == 2 {
            cell.movieEnum = .upcoming
            cell.apiManager = mainController.apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
            }
        } else {
            cell.movieEnum = .topRated
            cell.apiManager = mainController.apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
            }
        }
        return cell
    }
    
    // Headers
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Initial Setup
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "firstId", for: indexPath)
        let secondHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "secondId", for: indexPath)
        let thirdHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "thirdId", for: indexPath)
        let fourthHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "fourthId", for: indexPath)
        let screenWidth = UIScreen.main.bounds.width
        header.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        secondHeader.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        thirdHeader.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        fourthHeader.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        // Rows
        if indexPath.section == 0 {
            let secondHeaderTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: screenWidth - 40, height: 40))
                headerTitleLabel.text = "Popular"
                headerTitleLabel.textColor = UIColor.white
                headerTitleLabel.textAlignment = NSTextAlignment.left
                headerTitleLabel.backgroundColor = UIColor.clear
                headerTitleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 28)
                return headerTitleLabel
            }()
            secondHeader.addSubview(secondHeaderTitle)
            return secondHeader
        } else if indexPath.section == 1 {
            let thirdHeaderTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: screenWidth - 40, height: 40))
                headerTitleLabel.text = "Now Playing"
                headerTitleLabel.textColor = UIColor.white
                headerTitleLabel.textAlignment = NSTextAlignment.left
                headerTitleLabel.backgroundColor = UIColor.clear
                headerTitleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 28)
                return headerTitleLabel
            }()
            thirdHeader.addSubview(thirdHeaderTitle)
            return thirdHeader
        } else if indexPath.section == 2 {
            let fourthHeaderTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: screenWidth - 40, height: 40))
                headerTitleLabel.text = "Upcoming"
                headerTitleLabel.textColor = UIColor.white
                headerTitleLabel.textAlignment = NSTextAlignment.left
                headerTitleLabel.backgroundColor = UIColor.clear
                headerTitleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 28)
                return headerTitleLabel
            }()
            fourthHeader.addSubview(fourthHeaderTitle)
            return fourthHeader
        } else {
            let headerTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: screenWidth - 40, height: 40))
                headerTitleLabel.text = "Top Rated"
                headerTitleLabel.textColor = UIColor.white
                headerTitleLabel.textAlignment = NSTextAlignment.left
                headerTitleLabel.backgroundColor = UIColor.clear
                headerTitleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 28)
                return headerTitleLabel
            }()
            header.addSubview(headerTitle)
            return header
        }
    }
}
