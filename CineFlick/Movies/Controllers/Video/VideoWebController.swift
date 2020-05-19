//
//  VideoWebController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/8/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class VideoWebController: UIViewController, VideoWebDataProtocol {
    // References / Properties
    public lazy var videoWebView = VideoWebView()
    public lazy var detailController = DetailViewController()
    var webUrl: String = ""
    
    override func loadView() {
        super.loadView()
        view = videoWebView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDismissButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assignUrlToWebView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDisappearing()
    }
    
    
    private func onDisappearing() {
        webUrl = ""
        DispatchQueue.main.async {
            self.videoWebView.webView.reload()
        }
    }
    
    
    private func setDismissButton() {
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPersonController))
        saveBarButton.tintColor = UIColor(named: "TextColors")
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    
    private func assignUrlToWebView() {
        videoWebView.loadWebView(with: webUrl)
        DispatchQueue.main.async {
            self.videoWebView.webView.reload()
        }
    }
    
    // MARK: - Actions
    @objc private func dismissPersonController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
