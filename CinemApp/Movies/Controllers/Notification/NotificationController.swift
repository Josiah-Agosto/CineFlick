//
//  NotificationBanner.swift
//  CinemApp
//
//  Created by Josiah Agosto on 4/1/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class NotificationController {
    // MARK: Properties
    static let animationDuration = 0.5
    static let bannerAppearanceDuration: TimeInterval = 6.0
    static let slideMenuHelper = SlideMenuHelper()
    static let notificationView = NotificationView()
    
    static func displayError(message text: String) {
        let screenSuperView = slideMenuHelper.appDelegate!.navigationController!.visibleViewController!.view!
        notificationView.frame = CGRect(x: 0, y: screenSuperView.bounds.height, width: screenSuperView.bounds.width - 30, height: 64)
        // Label
        notificationView.errorLabel.text = text
        // Subviews
        screenSuperView.addSubview(notificationView)
        // Constraints
        notificationView.widthAnchor.constraint(equalTo: screenSuperView.widthAnchor, constant: -30).isActive = true
        notificationView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        notificationView.centerXAnchor.constraint(equalTo: screenSuperView.centerXAnchor).isActive = true
        let bannerBottomConstraint = NSLayoutConstraint(item: notificationView, attribute: .top, relatedBy: .equal, toItem: screenSuperView, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([bannerBottomConstraint])
        // Appearing
        UIView.animate(withDuration: animationDuration) {
            bannerBottomConstraint.constant = -40
            screenSuperView.layoutIfNeeded()
        }
        // On Disappearance
        UIView.animate(withDuration: animationDuration, delay: bannerAppearanceDuration, options: .curveEaseIn, animations: {
            bannerBottomConstraint.constant = 0
            screenSuperView.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                notificationView.removeFromSuperview()
            }
        })
    }
    
}
