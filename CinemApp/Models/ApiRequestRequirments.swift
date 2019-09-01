//
//  ApiRequestRequirments.swift
//  CinemApp
//
//  Created by Josiah Agosto on 8/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

protocol ApiRequestRequirements {
    // Api Request without Dates
    var titles: [String] { get set }
    var filmRatings: [String] { get set }
    var imageFilePaths: [String] { get set }
    func mainApiRequest(completionHandler: @escaping (_ titles: [String]?, _ filmRatings: [String]?, _ filePaths: [String]?, Error?) -> Void) -> Void
}
