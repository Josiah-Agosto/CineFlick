//
//  VideoWebView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/8/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class VideoWebView: UIView {
    // Properties / References
    public lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(named: "BackgroundColors")
        // Subview
        addSubview(webView)
        // Constraints
        constraints()
    }
    
    
    public func loadWebView(with url: String) {
        let requestUrl = URL(string: url)!
        webView.load(URLRequest(url: requestUrl))
    }
    
    
    private func constraints() {
        // Web View
        webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
