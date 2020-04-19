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
// References
    private let categoryView = Categories()
    private let movieCell = MovieCollectionViewCell()
    let popularRequest = PopularProcess()
    let nowPlayingRequest = NowPlayingProcess()
    let upcomingRequest = UpcomingProcess()
    let topRatedRequest = TopRatedProcess()
    let movieNetworkManager = NetworkManager()
    private var isOpen: Bool = false
// Buttons, Labels, etc.
    private let categoryButton = UIButton(frame: CGRect(x: 20, y: 10, width: 25, height: 25))
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        return collection
    }()
    public let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    public let loader = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.whiteLarge)
    let headerId = "headerId"
    let secondHeaderId = "secondId"
    let thirdHeaderId = "thirdId"
    let fourthHeaderId = "fourthHeaderId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        movieNetworkManager.makeApiCalls()
    }
    
    
    func initialSetup() {
    // View Appearance
        navigationController?.navigationBar.topItem?.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 50)!, NSAttributedString.Key.foregroundColor: UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0)]
        categoryButton.setImage(UIImage(named: "CategoryButton"), for: .normal)
        categoryButton.addTarget(self, action: #selector(categoryView(sender:)), for: .touchUpInside)
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: categoryButton)
        navigationController?.navigationBar.addSubview(categoryButton)
        view.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 1.0)
     // Collection View
        self.collectionView.allowsSelection = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    // Header
        self.collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        self.collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: secondHeaderId)
        self.collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: thirdHeaderId)
        self.collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: fourthHeaderId)
    // Inner Collection View Registered Cells
        movieCell.innerCollectionView.register(PopularMovieCellsCell.self, forCellWithReuseIdentifier: "movieCellsCell")
        movieCell.innerCollectionView.register(NowPlayingCellsCell.self, forCellWithReuseIdentifier: "nowPlayingCellsCell")
        movieCell.innerCollectionView.register(UpcomingCellsCell.self, forCellWithReuseIdentifier: "upcomingCellsCell")
        movieCell.innerCollectionView.register(TopRatedCellsCell.self, forCellWithReuseIdentifier: "topRatedCellsCell")
        view.addSubview(self.collectionView)
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
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.categoryView.view.frame = CGRect(x: 0, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
                self.view.addSubview(blurEffectView)
            }, completion: nil)
        } else {
            isOpen = false
            // Hides the Category View
            UIView.animate(withDuration: 0.5, animations: {
                self.categoryView.view.frame = CGRect(x: -window.frame.width - 90, y: 0, width: window.frame.width - 90.0, height: window.frame.height)
                // Removes the Blur Effect
                for subview in self.view.subviews {
                    if subview is UIVisualEffectView {
                        subview.removeFromSuperview()
                    }
                }
                // Category Button Animations
                UIView.animate(withDuration: 0.2) {
                    if self.isOpen == false {
                        self.categoryButton.transform = CGAffineTransform(rotationAngle: 0)
                    }
                }
            }, completion: nil)
        }
    }
    

    @objc private func blurEffectTap() {
        slideOutCategoriesView(shouldExpand: !isOpen)
    }
    
    
    private func handleSlideToggle() {
        isOpen = !isOpen
        slideOutCategoriesView(shouldExpand: isOpen)
    }
} // Class end


// Collection View Stuff
extension HomeScreenController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // This shouldn't be modified. In order to modify this it has to be in the Movie Collection View File
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    // Number of Sections in the View is shown here, not the amount in each row
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
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
        if indexPath.section == 1 {
            let secondHeaderTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
                headerTitleLabel.text = "Now Playing"
                headerTitleLabel.textColor = UIColor.white
                headerTitleLabel.textAlignment = NSTextAlignment.left
                headerTitleLabel.backgroundColor = UIColor.clear
                headerTitleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 28)
                return headerTitleLabel
            }()
            secondHeader.addSubview(secondHeaderTitle)
            return secondHeader
        } else if indexPath.section == 2 {
            let thirdHeaderTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
                headerTitleLabel.text = "Upcoming"
                headerTitleLabel.textColor = UIColor.white
                headerTitleLabel.textAlignment = NSTextAlignment.left
                headerTitleLabel.backgroundColor = UIColor.clear
                headerTitleLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 28)
                return headerTitleLabel
            }()
            thirdHeader.addSubview(thirdHeaderTitle)
            return thirdHeader
        } else if indexPath.section == 3 {
            let fourthHeaderTitle: UILabel = {
                let headerTitleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 40, height: 40))
                headerTitleLabel.text = "Top Rated"
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
                headerTitleLabel.text = "Popular"
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
} // Extension End
