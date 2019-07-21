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
    // Temporary Data Holders from JSON
    public var popularMovieTitles: [String] = []
    public var popularMovieFilmRatings: [Double] = []
    // References
    private var slideOutMenu: UIViewController!
    private var categoryView = Categories()
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
    let headerId = "headerId"
    // Network Managers Coming Soon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        popularMovieRequestTitles { (titles, error) in
            if let error = error {
                print(error)
            }
            print([titles])
        }
    }
    
    
    private func initialSetup() {
    // View Appearance
        navigationController?.navigationBar.topItem?.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 45)!, NSAttributedString.Key.foregroundColor: UIColor(red: 145/255, green: 36/255, blue: 36/255, alpha: 1.0)]
        categoryButton.setImage(UIImage(named: "CategoryButton"), for: .normal)
        categoryButton.addTarget(self, action: #selector(categoryView(sender:)), for: .touchUpInside)
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: categoryButton)
        navigationController?.navigationBar.addSubview(categoryButton)
        createGradient(first: UIColor(red: 114/255, green: 104/255, blue: 104/255, alpha: 1.0), second: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
     // Collection View
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    // Header
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        view.addSubview(collectionView)
    }
    
    // Movie Title Request
    public func popularMovieRequestTitles(completionHandler: @escaping (_ title: [String]?, Error?) -> Void) -> Void {
        // Api Key Location
        let secretApiKey: String = apiKey
        let group = DispatchGroup()
        // Insert YOUR API KEY here, Remove Underscore and enter a title.
        let _: String = ""
        // Data Request
        let popularMovieDataURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(secretApiKey)&language=en-US&page=1")!
        // Session for getting Data
        let session = URLSession.shared
        let dataTask = session.dataTask(with: popularMovieDataURL) {
            data, response, error in
            guard let data = data else {
                print("Error recieving URL!")
                return
            }
            do {
                let popularMovies = try JSONDecoder().decode(MovieDetail.self, from: data)
                self.popularMovieTitles.removeAll()
                group.enter()
                for titles in popularMovies.results {
                    self.popularMovieTitles.append(titles.title)
                }
                group.leave()
                group.notify(queue: DispatchQueue.main, execute: {
                    print("Notifying")
                    completionHandler(self.popularMovieTitles, nil)
                })
            } catch let JSONError {
                completionHandler(nil, JSONError)
            }
        }
        dataTask.resume()
    }
    
    // Gradient Background
    private func createGradient(first colorOne: UIColor, second colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.62, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // Animation for Pressing Image Button
    @objc private func categoryView(sender: UIBarButtonItem) {
        // When the Category button is pressed
        handleSlideToggle()
    }
    
    // Slide Menu Effects
    private func slideOutCategoriesView(shouldExpand: Bool) {
        // Adding Blur Effect in background
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
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
        return 1
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 55)
    }
    
}
