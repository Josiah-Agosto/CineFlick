//
//  SelectedVideoProtocol.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/6/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

protocol SelectedVideoProtocol: class {
    func selectedVideo(_ key: String, _ videoCell: VideoCollectionViewCell)
}
