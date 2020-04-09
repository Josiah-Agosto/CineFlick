//
//  InternetNetwork.swift
//  CinemApp
//
//  Created by Josiah Agosto on 3/24/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import Network

// TODO: Change UIAlertController to Custom View

class InternetNetwork {
    private let monitor = NWPathMonitor()
    private var parentViewController: UIViewController!
    
    init(parent: UIViewController) {
        self.parentViewController = parent
    }
    
    public func checkForInternetConnectivity() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                print("No Connection")
                DispatchQueue.main.async {
                    self.displayErrorAlertController(title: "No Internet Connection", message: "Please Connect to the Internet in order to continue.",  preferredStyle: .alert) { (errorController) in
                        DispatchQueue.main.async {
                            self.parentViewController.present(errorController, animated: true)
                        }
                    }
                } // Main Queue
            }
        } // Monitor End
    }
           
    // No Internet Alert
    private func displayErrorAlertController(title titleParam: String?, message messageParam: String?, preferredStyle preferredStyleParam: UIAlertController.Style, completion: @escaping((UIAlertController) -> Void)) {
        let errorAlertController = UIAlertController(title: titleParam, message: messageParam, preferredStyle: preferredStyleParam)
//        DispatchQueue.main.async {
            errorAlertController.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: { (action) in
                self.checkForInternetConnectivity()
            }))
//        }
//        DispatchQueue.main.async {
            completion(errorAlertController)
//        }
    }
    
}
