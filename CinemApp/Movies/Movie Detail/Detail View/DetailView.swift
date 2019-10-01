//
//  DetailView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/21/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIViewController {
    // References
    lazy var apiManager = APINetworkManager()
    // Collection View
    let castCollectionView: UICollectionView = {
        let viewLayout = CastCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: viewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 5
        collectionView.bounces = false
        return collectionView
    }()
// Appearance
    // Scroll View
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = UIColor.clear
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.layer.cornerRadius = 10
        scroll.contentSize.height = 875
        return scroll
    }()
    // Goes back to Home Screen
    let removeDetailButton: UIButton = {
        let remover = UIButton()
        remover.setTitle("X", for: .normal)
        remover.backgroundColor = UIColor.black
        remover.titleLabel?.textColor = UIColor.black
        remover.layer.cornerRadius = 15
        remover.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
        remover.addTarget(self, action: #selector(removeDetailView(sender:)), for: .touchUpInside)
        return remover
    }()
    // Backdrop Image
    let backdropImage: UIImageView = {
        let backdrop = UIImageView()
        backdrop.backgroundColor = UIColor.clear
        backdrop.layer.cornerRadius = 8
        backdrop.layer.layoutIfNeeded()
        return backdrop
    }()
    // Movie Rating
    let movieRating: UILabel = {
        let rating = UILabel()
        rating.text = "83"
        rating.numberOfLines = 1
        rating.backgroundColor = UIColor.clear
        rating.textAlignment = NSTextAlignment.center
        rating.layer.cornerRadius = 25
        rating.layer.borderWidth = 3
        rating.layer.borderColor = UIColor.green.cgColor
        rating.font = UIFont(name: "AvenirNext-Bold", size: 20)
        rating.textColor = UIColor.green
        return rating
    }()
    // Movie Title Placeholder
    private let titlePlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "Title:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Movie Title
    let movieTitle: UILabel = {
        let title = UILabel()
        title.text = "Title"
        title.numberOfLines = 0
        title.backgroundColor = UIColor.clear
        title.textAlignment = NSTextAlignment.left
        title.font = UIFont(name: "AvenirNext-Bold", size: 25)
        return title
    }()
    // Release Date Placeholder
    private let releasePlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "Release Date:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Release Date
    let releaseDate: UILabel = {
        let releaseTitle = UILabel()
        releaseTitle.text = "Release"
        releaseTitle.backgroundColor = UIColor.clear
        releaseTitle.numberOfLines = 1
        releaseTitle.textAlignment = NSTextAlignment.left
        releaseTitle.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return releaseTitle
    }()
    // Overview Placeholder
    private let overviewPlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "Overview:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Movie Overview Message
    let overview: UILabel = {
        let overviewTitle = UILabel()
        overviewTitle.text = "Overview"
        overviewTitle.numberOfLines = 0
        overviewTitle.backgroundColor = UIColor.clear
        overviewTitle.textAlignment = NSTextAlignment.left
        overviewTitle.textColor = UIColor.white
        overviewTitle.sizeToFit()
        overviewTitle.font = UIFont(name: "AvenirNext", size: 18)
        return overviewTitle
    }()
    // Runtime Placeholder
    private let runtimePlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "Runtime:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    // Runtime
    let runtime: UILabel = {
        let runtimeTitle = UILabel()
        runtimeTitle.text = "Runtime"
        runtimeTitle.numberOfLines = 1
        runtimeTitle.backgroundColor = UIColor.clear
        runtimeTitle.textAlignment = NSTextAlignment.left
        runtimeTitle.font = UIFont(name: "AvenirNext", size: 12)
        return runtimeTitle
    }()
    // Cast Placeholder
    let castPlaceholder: UILabel = {
        let placeholder = UILabel()
        placeholder.text = "Cast:"
        placeholder.textAlignment = NSTextAlignment.left
        placeholder.numberOfLines = 1
        placeholder.font = UIFont(name: "AvenirNext-Medium", size: 20)
        return placeholder
    }()
    private let blur = UIBlurEffect(style: UIBlurEffect.Style.light)
    // Data transfer Holders
    var castCountForSection: Int = 0
    var name: [String] = []
    var charName: [String] = []
    var profileImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        // Sizes
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        // View
        view.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 0)
        view.frame = CGRect(x: 10, y: 40, width: screenWidth - 20, height: screenHeight - 60)
        view.layer.cornerRadius = 10
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = CGRect(x: -10, y: 0, width: screenWidth - 10, height: 1010)
        blurView.layer.cornerRadius = 10
    // MARK: - Frames in Order of View
        // Remover Button
        removeDetailButton.frame = CGRect(x: screenWidth - 60, y: 5, width: 30, height: 30)
        // Backdrop
        backdropImage.frame = CGRect(x: 10, y: 10, width: screenWidth - 40, height: 210)
        // Movie Rating
        movieRating.frame = CGRect(x: 20, y: 160, width: 50, height: 50)
        // Title
        titlePlaceholder.frame = CGRect(x: 10, y: 230, width: screenWidth, height: 20)
        movieTitle.frame = CGRect(x: 10, y: 250, width: screenWidth - 40, height: 80)
        // Runtime
        runtimePlaceholder.frame = CGRect(x: 10, y: 340, width: screenWidth, height: 20)
        runtime.frame = CGRect(x: 10, y: 360, width: 80, height: 30)
        // Release
        releasePlaceholder.frame = CGRect(x: 10, y: 400, width: screenWidth, height: 20)
        releaseDate.frame = CGRect(x: 10, y: 420, width: screenWidth - 40, height: 30)
        // Overview
        overviewPlaceholder.frame = CGRect(x: 10, y: 460, width: screenWidth - 40, height: 20)
        overview.frame = CGRect(x: 10, y: 480, width: screenWidth - 40, height: 180)
        // Collection View for Cast
        castPlaceholder.frame = CGRect(x: 10, y: 670, width: screenWidth - 40, height: 20)
        castCollectionView.frame = CGRect(x: 10, y: 700, width: screenWidth - 40, height: 180)
    // MARK: - Subviews
        view.addSubview(scrollView)
        view.addSubview(removeDetailButton)
        // To Scroll View, In order
        scrollView.addSubview(blurView)
        scrollView.addSubview(backdropImage)
        scrollView.addSubview(movieRating)
        scrollView.addSubview(titlePlaceholder)
        scrollView.addSubview(movieTitle)
        scrollView.addSubview(runtimePlaceholder)
        scrollView.addSubview(runtime)
        scrollView.addSubview(releasePlaceholder)
        scrollView.addSubview(releaseDate)
        scrollView.addSubview(overviewPlaceholder)
        scrollView.addSubview(overview)
        scrollView.addSubview(castPlaceholder)
        scrollView.addSubview(castCollectionView)
        constraints()
        extraSetup()
    }
    
    private func extraSetup() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.allowsSelection = false
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    
    private func constraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -5).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    @objc private func removeDetailView(sender: UIButton) {
        self.view.removeFromSuperview()
    }

} // Class End

// Collection View
// Delegate
extension DetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}


// Data Source
extension DetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castCountForSection
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CastCollectionViewCell
        cell.name.text = name[safe: indexPath.row] ?? ""
        cell.characterName.text = charName[safe: indexPath.row] ?? ""
        cell.person.image = profileImage[safe: indexPath.row] ?? UIImage(named: "ImageNotFound")
        return cell
    }
}
