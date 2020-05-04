//
//  LanguageDelegate.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/1/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension LanguageController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let unselectedCell = tableView.cellForRow(at: indexPath) as! LanguageCell
        let selectedCell = tableView.cellForRow(at: Constants.selectedIndex) as! LanguageCell
        if indexPath == Constants.selectedIndex {
            return
        }
        if unselectedCell.accessoryType == UITableViewCell.AccessoryType.none {
            unselectedCell.accessoryType = .checkmark
        }
        if selectedCell.accessoryType == .some(.checkmark) {
            selectedCell.accessoryType = .none
        }
        Constants.selectedIndex = indexPath
        Constants.selectedLanguage = unselectedCell.languageEnum
        Constants.selectedRegion = unselectedCell.regionEnum
    }
    
}
