//
//  ImageResult.swift
//  CinemApp
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum ImageResult<U, V> where V: Error {
    case success(U)
    case failure(V)
}
