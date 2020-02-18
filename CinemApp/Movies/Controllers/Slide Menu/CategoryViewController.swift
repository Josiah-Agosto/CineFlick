//
//  SlideMenuEffectController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/11/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class CategoryViewController: UIViewController {
    private var categoryView: CategoryView!
    private var isOpen: Bool = false
    
    override func loadView() {
        categoryView = CategoryView()
        view = categoryView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        
    }
    
} // Class end



extension CategoryViewController: CategoryViewProtocol {
    func handleSlideToggle() {
        isOpen = !isOpen
        categoryView.slideOutCategoriesView(shouldExpand: isOpen)
    }
}
