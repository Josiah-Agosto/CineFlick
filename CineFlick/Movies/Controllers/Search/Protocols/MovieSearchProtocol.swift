//
//  MovieSearchProtocol.swift
//  CineFlick
//
//  Created by Josiah Agosto on 5/4/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

protocol MovieSearchProtocol: class {
    func didSelectMovie()
}


protocol searchMovieIdProtocol: class {
    var movieId: String { get set }
}
