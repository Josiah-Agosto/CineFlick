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
    
    override func loadView() {
        super.loadView()
        view = languageView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        
    }

}



extension LanguageController: ChangeToLanguageControllerProtocol {
    func pushLanguagesToController() {
        print("Poopy")
    }
}
