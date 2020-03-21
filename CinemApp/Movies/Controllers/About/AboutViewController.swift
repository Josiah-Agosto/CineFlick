//
//  AboutController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: UIViewController {
    // Properties
    private var aboutView: AboutView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    
    override func loadView() {
        aboutView = AboutView()
        view = aboutView
    }
    
    
    private func setup() {
        navigationController?.title = "About"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}
