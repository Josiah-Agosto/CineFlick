//
//  LanguageDataSource.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/1/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension LanguageController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguagesEnum.allCases.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let languageCell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseIdentifier, for: indexPath) as! LanguageCell
        languageCell.selectionStyle = .none
        languageCell.englishLanguageName.text = configurationManager.languageEnumNamesStrings()[indexPath.row]
        languageCell.nativeLanguageName.text = configurationManager.nativeLanguageNamesStrings()[indexPath.row]
        languageCell.languageCode.text = configurationManager.languageIsoEnumStrings()[indexPath.row]
        switch indexPath.row {
        case 0: languageCell.languageEnum = .English; languageCell.regionEnum = .English
        case 1: languageCell.languageEnum = .Italian; languageCell.regionEnum = .Italian
        case 2: languageCell.languageEnum = .Chinese; languageCell.regionEnum = .Chinese
        case 3: languageCell.languageEnum = .Hindi; languageCell.regionEnum = .Hindi
        case 4: languageCell.languageEnum = .Spanish; languageCell.regionEnum = .Spanish
        case 5: languageCell.languageEnum = .French; languageCell.regionEnum = .French
        case 6: languageCell.languageEnum = .Arabic; languageCell.regionEnum = .Arabic
        case 7: languageCell.languageEnum = .Bengali; languageCell.regionEnum = .Bengali
        case 8: languageCell.languageEnum = .Russian; languageCell.regionEnum = .Russian
        case 9: languageCell.languageEnum = .Portuguese; languageCell.regionEnum = .Portuguese
        case 10: languageCell.languageEnum = .Indonesian; languageCell.regionEnum = .Indonesian
        default: break
        }
        return languageCell
    }

}
