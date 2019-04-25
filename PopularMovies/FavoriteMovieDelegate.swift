//
//  AddToFavoriteDelegate.swift
//  PopularMovies
//
//  Created by jets on 7/30/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import Foundation

protocol FavoriteMovieDelegate {
    func addToFavorite(movie: MovieDTO)
}
