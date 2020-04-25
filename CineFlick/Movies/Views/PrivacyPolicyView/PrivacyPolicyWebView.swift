//
//  PrivacyPolicyWebView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/23/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit
import WebKit

class PrivacyPolicyWebView: UIView {
    // References
    private lazy var privacyPolicyController = PrivacyPolicyController()
    // Web View
    public lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.white
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.white
        addSubview(webView)
        constraints()
    }
    
    
    private func constraints() {
        // Web View
        webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
