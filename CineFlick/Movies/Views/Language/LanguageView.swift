//
//  LanguageView.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class LanguageView: UIView {
    // Properties / References
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseIdentifier)
        tableView.allowsMultipleSelection = false
        tableView.estimatedRowHeight = 70
        tableView.allowsSelection = true
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(named: "BackgroundColors")
        // Subviews
        addSubview(tableView)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        // Table View
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
