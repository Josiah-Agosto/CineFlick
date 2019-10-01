//
//  ViewController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/10/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation
// TIP: - When programmatically making Navigation Bars you need to NOT subclass it as a UINavigationController
class HomeScreenController: UIViewController {
    private var isOpen: Bool = false
    private let headerId = "headerId"
    private let secondHeaderId = "secondId"
    private let thirdHeaderId = "thirdId"
    private let fourthHeaderId = "fourthHeaderId"
    // Buttons, Labels, etc.
    private let categoryButton = UIButton(frame: CGRect(x: 20, y: 10, width: 25, height: 25))
    public let collectionView: UICollectionView = {
        let layout = MainCollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        return collection
    }()
    // References
    private let window = UIApplication.shared.keyWindow
    public let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private var apiManager = APINetworkManager()
    private var categoryView = Categories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        apiManager.makeApiRequest {
            // Reloading
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                for cell in self.collectionView.visibleCells {
                    if let cell = cell as? MovieCollectionViewCell {
                        cell.innerCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    
    func initialSetup() {
        // View Appearance
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
        navigationController?.navigationBar.topItem?.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 50)!, NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)]
        categoryButton.setImage(UIImage(named: "CategoryButton"), for: .normal)
        categoryButton.addTarget(self, action: #selector(categoryView(sender:)), for: .touchUpInside)
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: categoryButton)
        navigationController?.navigationBar.addSubview(categoryButton)
        // Collection View
        collectionView.allowsSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // Header
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: secondHeaderId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: thirdHeaderId)
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fourthHeaderId)
        view.addSubview(collectionView)
    }
    
    // Animation for Pressing Image Button
    @objc private func categoryView(sender: UIBarButtonItem) {
        // When the Category button is pressed
        handleSlideToggle()
    }
    
    // Slide Menu Effects
    private func slideOutCategoriesView(shouldExpand: Bool) {
        // Adding Blur Effect in background
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(categoryView.view)
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(blurEffectTap)))
        // Starting point
        categoryView.view.frame = CGRect(x: -window.frame.width - 90, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
        if shouldExpand {
            // Category Button Animation
            UIView.animate(withDuration: 0.2) {
                if self.isOpen == true {
                    self.categoryButton.transform = CGAffineTransform(rotationAngle: 30)
                }
            }
            // Pop-In of Category View
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.categoryView.view.frame = CGRect(x: 0, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
                self.view.addSubview(blurEffectView)
            }, completion: nil)
        } else {
            self.isOpen = false
            // Hides the Category View
            UIView.animate(withDuration: 0.9, animations: {
                self.categoryView.view.frame = CGRect(x: -window.frame.width - 90, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
                // Category Button Animations
                UIView.animate(withDuration: 0.6) {
                    // Removes the Blur Effect
                    for subview in self.view.subviews {
                        if subview is UIVisualEffectView {
                            subview.removeFromSuperview()
                        }
                    }
                }
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    if self.isOpen == false {
                        self.categoryButton.transform = CGAffineTransform(rotationAngle: 0)
                    }
                })
            })
        } // Else
    } // Func End
    
    
    @objc private func blurEffectTap() {
        UIView.animate(withDuration: 0.6) {
            self.slideOutCategoriesView(shouldExpand: !self.isOpen)
        }
    }
    
    
    private func handleSlideToggle() {
        isOpen = !isOpen
        slideOutCategoriesView(shouldExpand: isOpen)
    }
} // Class end


// Delegate
extension HomeScreenController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width - 10, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
} // Extension End


// Data Source
extension HomeScreenController: UICollectionViewDataSource {
    // This shouldn't be modified. In order to modify this it has to be in the Movie Collection View File
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // Number of Sections in the View is shown here, not the amount in each row
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Able to access the MoviecollectionViewCell because of the dequeueReusableCell constant. No need for reference.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor.clear
        if indexPath.section == 0 {
            cell.movieEnum = .popular
            cell.apiManager = apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
                
            }
        } else if indexPath.section == 1 {
            cell.movieEnum = .nowPlaying
            cell.apiManager = apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
                cell.detail.castCollectionView.reloadData()
            }
        } else if indexPath.section == 2 {
            cell.movieEnum = .upcoming
            cell.apiManager = apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
            }
        } else {
            cell.movieEnum = .topRated
            cell.apiManager = apiManager
            DispatchQueue.main.async {
                cell.innerCollectionView.reloadData()
            }
        }
        return cell
    }
    
    // Headers
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Initial Setup
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        let secondHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: secondHeaderId, for: indexPath)
        let thirdHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: thirdHeaderId, for: indexPath)
        let fourthHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: fourthHeaderId, for: indexPath)
        header.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        secondHeader.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        thirdHeader.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        fourthHeader.backgroundColor = UIColor(red: 58/255, green: 15/255, blue: 15/255, alpha: 1.0)
        // Rows
        if indexPath.section == 0 {
            let secondHeaderTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
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
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
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
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
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
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
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
} // DataSource End


// This is needed to have the items placed fromthe UICollectionViewFlowLayout used in the Instantce of Collection View
extension HomeScreenController: UICollectionViewDelegateFlowLayout {
}
