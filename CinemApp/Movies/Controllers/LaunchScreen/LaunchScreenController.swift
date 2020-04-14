//
//  LaunchScreenController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 3/16/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit
import Foundation

class LaunchScreenController: UIViewController, LaunchScreenProtocol {
    // Properties
    public var launchView: LaunchScreenView!
        
    override func loadView() {
        launchView = LaunchScreenView()
        view = launchView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        navigationItem.hidesBackButton = true
        launchView.dataActivityIndicator.startAnimating()
    }

    // MARK: Delegate Function
    func isLoadingFinished(_ dataLoaded: Bool) {
        if dataLoaded == true {
            DispatchQueue.main.async {
                self.launchView.dataActivityIndicator.stopAnimating()
                self.navigationController?.popToRootViewController(animated: false)
            }
        } else {
            errorAlertController()
        }
    }
    
    
    private func errorAlertController() {
        let alertController = UIAlertController(title: "Error accessing API!", message: "Please, try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            print("I don't know")
        }))
    }
}
