//
//  SlideMenuHelper.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/12/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

struct SlideMenuHelper {
    // MARK: Properties
    public let appDelegate = UIApplication.shared.delegate as? AppDelegate
    public var isOpen: Bool = false

    /// Main function to check get slide menu's state
    public func shouldExpandSlideMenu(_ expanded: Bool, completion: ((Bool) -> Void)? = nil) {
        if expanded {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                let screenWidth = UIScreen.main.bounds.width
                self.appDelegate?.navigationController?.view.frame.origin.x = screenWidth - 100
            }, completion: nil)
            completion?(expanded)
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.appDelegate?.navigationController?.view.frame.origin.x = 0
            }, completion: nil)
            completion?(expanded)
        }
    }

    /// Adds slide menu to window and window to view
    public func addSlideMenuToWindow(_ viewController: inout SlideViewController!) {
        if viewController == nil {
            let window = appDelegate?.window
            guard let newWindow = window else { return }
            viewController = SlideViewController()
            viewController?.view.tag = 1
            viewController?.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height)
            newWindow.addSubview(viewController?.view ?? UIView())
        }
    }

    /// Removes slide menu and window
    public func removeSlideMenuToWindow(_ viewController: inout SlideViewController!) {
        if viewController != nil {
            let window = appDelegate?.window
            guard let newWindow = window else { return }
            newWindow.viewWithTag(1)?.removeFromSuperview()
            viewController = nil
        }
    }
    
}
