//
//  ImageProcessorRequirements.swift
//  CinemApp
//
//  Created by Josiah Agosto on 8/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

protocol ImageProcessorRequirements {
    // Three Main Components to generate an Image, Base_Url, Size and File_Path, then an Image Array which should be the holder for the Request
    // Full URL Order: Secured Url, Size, File Path.
    var filePath: [String] { get set }
    var secureImageUrl: String { get set }
    var imageSize: String { get set }
    var fullImageUrl: [String] { get set }
    var movieImages: [UIImage] { get set }
    func filePathRequest(completionHandler: @escaping (_ filePath: [String]?, Error?) -> Void) -> Void
    func convertToUrl(completionHandler: @escaping (_ fullUrl: [String]?, Error?) -> Void) -> Void
    func makeUrlAnImage(completionHandler: @escaping (_ image: [UIImage]?, Error?) -> Void) -> Void
}
