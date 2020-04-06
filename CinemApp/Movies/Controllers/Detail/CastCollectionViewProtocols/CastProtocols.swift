//
//  CastDataSourceProtocol.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

protocol CastDataSourceProtocol: class {
    var castCountForSection: Int { get set }
    var name: [String] { get set }
    var charName: [String] { get set }
    var profileImage: [UIImage] { get set }
}


protocol CastMovieIdProtocol: class {
    var castMovieId: String { get set }
}
