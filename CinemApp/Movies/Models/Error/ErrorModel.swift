//
//  ErrorModel.swift
//  CinemApp
//
//  Created by Josiah Agosto on 4/1/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct ErrorModel: Error {
    var localizedDescription: String
    
    init(errorMessage: String) {
        self.localizedDescription = errorMessage
    }
}
