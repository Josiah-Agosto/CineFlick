//
//  SlideMenuEffect.swift
//  CinemApp
//
//  Created by Josiah Agosto on 6/11/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class SlideMenuEffect: UIViewController {
    var parentController: HomeScreenController!
    var slideOutController: Categories!
    var isOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func slideOutCategoriesView(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.25, animations: {
                self.view.frame.origin.x = self.view.frame.width - 75
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                self.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
} // Class end



extension SlideMenuEffect: SlideControllerDelegate {
    func handleSlideToggle() {
        isOpen = !isOpen
        slideOutCategoriesView(shouldExpand: isOpen)
    }
}
