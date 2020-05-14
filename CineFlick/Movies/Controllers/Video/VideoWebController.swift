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
        setup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assignUrlToWebView()
    }
    
    
    private func setup() {
        // Navigation
        // TODO: Make the Navigation Bars and Toolbars nicer.
    }
    
    
    private func assignUrlToWebView() {
        videoWebView.loadWebView(with: webUrl)
        DispatchQueue.main.async {
            self.videoWebView.webView.reload()
        }
    }
    
}
