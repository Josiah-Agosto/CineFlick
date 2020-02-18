//
//  MainScreenView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MainScreenView: UIView {
    // Buttons, Labels, etc.
    private let categoryButton = UIButton(frame: CGRect(x: 20, y: 10, width: 25, height: 25))
    public let collectionView: UICollectionView = {
        let layout = MainCollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150), collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        return collection
    }()
    // References
    public let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    private let refreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    private func setup() {
        addSubview(collectionView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
