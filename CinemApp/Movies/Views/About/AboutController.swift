//
//  AboutController.swift
//  CinemApp
//
//  Created by Josiah Agosto on 10/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class AboutController: UIView {
    // Creator Label
    let creatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Creator:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        return label
    }()
    // Creator
    let creator: UILabel = {
        let label = UILabel()
        label.text = "Josiah Agosto"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        return label
    }()
    // GitHub Label
    let githubLabel: UILabel = {
        let label = UILabel()
        label.text = "Github:"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        return label
    }()
    // Github Name
    let githubName: UILabel = {
        let label = UILabel()
        label.text = "UnknownEncrypter"
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationController?.navigationBar.topItem?.title = "About"
        navigationController?.navigationBar.prefersLargeTitles = false
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        // View
        backgroundColor = UIColor.green
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        // Frames
        creatorLabel.frame = CGRect(x: 10, y: 15, width: width, height: 35)
        creator.frame = CGRect(x: 10, y: 60, width: width, height: 30)
        githubLabel.frame = CGRect(x: 10, y: 100, width: width, height: 35)
        githubName.frame = CGRect(x: 10, y: 140, width: width, height: 30)
        // Subviews
        addSubview(creatorLabel)
        addSubview(creator)
        addSubview(githubLabel)
        addSubview(githubName)
    }
}
