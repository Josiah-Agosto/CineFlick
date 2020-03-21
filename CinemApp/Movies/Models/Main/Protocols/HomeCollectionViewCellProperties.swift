//
//  HomeCollectionViewCellProperties.swift
//  CinemApp
//
//  Created by Josiah Agosto on 2/23/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

protocol HomeCollectionViewCellProperties {
    var castCountForSection: Int { get set }
    var castActorName: [String] { get set }
    var castCharacterName: [String] { get set }
    var castProfileImage: [UIImage] { get set }
}
