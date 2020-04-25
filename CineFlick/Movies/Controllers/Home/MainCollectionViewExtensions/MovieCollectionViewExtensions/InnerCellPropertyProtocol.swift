//
//  InnerCellPropertyProtocol.swift
//  CineFlick
//
//  Created by Josiah Agosto on 3/2/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

protocol InnerSelectedCellProtocol: class {
    func isCellSelectedHandler()
    var isCellSelected: Bool { get set }
}


protocol InnerSelectedIdProtocol: class {
    var movieId: String { get set }
    var movieName: String { get set }
    var selectedBackdropUrl: String { get set }
}
