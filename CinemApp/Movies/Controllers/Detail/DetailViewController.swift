//
//  DetailViewController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, CastDataSourceProtocol {
    // Data Source Properties
    var castCountForSection: Int = 0
    var name: [String] = []
    var charName: [String] = []
    var profileImage: [UIImage] = []
    // References
    public lazy var detailView = DetailView()
    public lazy var detailManager = DetailNetworkManager()
    public weak var homeController: HomeScreenController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
        
    
    override func loadView() {
        view = detailView
    }
    
    
    private func setup() {
        // Navigation Controller
        navigationController?.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.black
        // Data Source
        detailView.castDataSource.castCountForSection = castCountForSection
        detailView.castDataSource.name = name
        detailView.castDataSource.charName = charName
        detailView.castDataSource.profileImage = profileImage
    }


}
