//
//  PersonDataProtocol.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/3/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

protocol PersonIdProtocol: class {
    var personId: String { get set }
}


protocol PersonSelectionProtocol: class {
    func hasSelectedCell()
}
