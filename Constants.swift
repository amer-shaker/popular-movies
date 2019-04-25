//
//  Constants.swift
//  PopularMovies
//
//  Created by jets on 7/27/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import Foundation

class Constants {
    
    static let API_KEY: String = "api_key=f4258993ae56bb0b63b3f18b140e2060"
    
    // URLs
    static let MOVIES_BASE_URL: String = "https://api.themoviedb.org/3/discover/movie?"
    static let MOVIES_SORT_BY_POPULARITY = "sort_by=popularity.desc&"
    static let MOVIES_SORT_BY_TOP_RATED = "sort_by=top_rated&"

    static let IMAGES_BASE_URL: String = "https://image.tmdb.org/t/p/"
    static let IMAGE_SIZE_92: String = "w92"
    static let IMAGE_SIZE_154: String = "w154"
    static let IMAGE_SIZE_185: String = "w185"
    static let IMAGE_SIZE_342: String = "w342"
    static let IMAGE_SIZE_500: String = "w500"
    static let IMAGE_SIZE_780: String = "w780"
    static let IMAGE_SIZE_ORIGINAL: String = "original"

    static let TRAILERS_BASE_URL: String = "https://api.themoviedb.org/3/movie/"
    static let TRAILERS_MOVIE_ID: String = "/videos?"

    static let SHOW_MOVIE_COLLECTION_VIEW_ID: String = "movieCV"
    
    static let REVIEWS_BASE_URL: String = "https://api.themoviedb.org/3/movie/"
    static let REVIEWS_MOVIE_ID: String = "/reviews?"
    
    // Core Data
    static let MOVIE_ENTITY: String = "MovieEntity"

}
