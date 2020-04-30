//
//  PrivacyPolicyController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/23/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit
import WebKit

final class PrivacyPolicyController: UIViewController {
    // References / Properties
    private lazy var privacyPolicyView = PrivacyPolicyWebView()
    
    override func loadView() {
        view = privacyPolicyView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setup()
    }
    
    
    private func setupNavigationController() {
        navigationItem.hidesBackButton = true
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonAction))
        navigationItem.leftBarButtonItem = doneButton
        doneButton.tintColor = UIColor.white
    }
    
    
    private func setup() {
        // Privacy Policy Web View
        guard let url = URL(string: Constants.privacyPolicyUrl) else { NotificationController.displayError(message: "Unable to access Privacy Policy, please check back later."); return }
        privacyPolicyView.webView.load(URLRequest(url: url))
    }
    
    
    @objc private func doneButtonAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    deinit {
        privacyPolicyView.webView.stopLoading()
    }
}
