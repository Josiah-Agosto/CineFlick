//
//  InnerCellPropertyProtocol.swift
//  CinemApp
//
//  Created by Josiah Agosto on 3/2/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

protocol InnerSelectedCellProtocol: class {
    func selectedCell(isSelected: Bool)
}


protocol InnerSelectedIdProtocol: class {
    var movieId: String { get set }
}
