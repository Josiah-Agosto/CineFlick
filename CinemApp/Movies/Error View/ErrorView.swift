//
//  ErrorView.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/8/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class ErrorView: UIView {
    let errorTitle = UILabel(frame: CGRect(x: 5, y: 5, width: 20, height: 18))
    let errorHolder = UILabel(frame: CGRect(x: 15, y: 25, width: UIScreen.main.bounds.width - 40, height: 25))
    let connectionErrorMessage: String = "Hmm, Seems like there's a problem with your Internet Connection."
    
    fileprivate func errorOccured() {
        self.backgroundColor = UIColor(red: 210/255, green: 75/255, blue: 69/255, alpha: 1)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 8)
        errorTitle.text = "Error"
        errorTitle.font = UIFont(name: "Avenir-Next", size: 18)
        errorHolder.text = connectionErrorMessage
        errorHolder.font = UIFont(name: "Avenir-Next", size: 20)
    }
}
