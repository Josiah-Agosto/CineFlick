//
//  LanguageController.swift
//  CineFlick
//
//  Created by Josiah Agosto on 4/30/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class LanguageController: UIViewController {
    // References / Properties
    public lazy var languageView = LanguageView()
    public lazy var configurationManager = ConfigurationManager.shared
    private lazy var homeController = HomeScreenController()
    private lazy var slideController = SlideViewController()
    // Updater Delegate
    public weak var updateViewDelegate: LanguageViewUpdaterProtocol?
    
    override func loadView() {
        super.loadView()
        view = languageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        defaultSelectedRow()
    }
    
    
    private func setup() {
        // Table View Delegates
        languageView.tableView.delegate = self
        languageView.tableView.dataSource = self
        self.updateViewDelegate = slideController
        // Navigation Bar
        title = "Languages"
        setSaveButton()
    }
    
    // MARK: - Private Functions
    private func setSaveButton() {
        let saveBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonAction))
        saveBarButton.tintColor = UIColor(named: "TextColors")
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    
    private func defaultSelectedRow() {
        languageView.tableView.selectRow(at: Constants.selectedIndex, animated: true, scrollPosition: .top)
        languageView.tableView.cellForRow(at: Constants.selectedIndex)?.accessoryType = .checkmark
    }
    
    // MARK: - Actions
    @objc private func saveButtonAction() {
        dismiss(animated: true, completion: nil)
        updateViewDelegate?.currentCountryCode = Constants.selectedRegion.rawValue
    }

}


// MARK: - When View is Pushed
extension LanguageController: ChangeToLanguageControllerProtocol {
    func pushLanguagesToController() {
    }
}
