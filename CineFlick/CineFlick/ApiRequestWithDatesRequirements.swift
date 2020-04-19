//
//  ApiRequestWithDatesRequirements.swift
//  CinemApp
//
//  Created by Josiah Agosto on 7/28/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

protocol ApiRequestWithDatesRequirements {
    // Get Title and Release/Released Dates
    var allTitles: [String] { get set }
    var allDates: [String] { get set }
    func mainDataRequest(completionHandler: @escaping (_ titles: [String]?, _ dates: [String]?, Error?) -> Void) -> Void
}
