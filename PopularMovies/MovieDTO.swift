//
//  MovieAPIResponse.swift
//  PopularMovies
//
//  Created by jets on 7/28/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieAPIResponse: Mappable {
    
    var movies: [MovieDTO]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        movies <- map["results"]
    }
}

class MovieDTO: Mappable {
    
    var id : Int?
    var title : String?
    var originalTitle : String?
    var originalLanguage : String?
    var overview : String?
    var posterPath : String?
    var backdropPath : String?
    var releaseDate : String?
    var popularity : Double?
    var voteAverage : Double?
    var voteCount : Int?
    var adult : Bool?
    var trailers: [TrailerDTO] = []
    var reviews: [ReviewDTO] = []
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        originalTitle <- map["original_title"]
        originalLanguage <- map["original_language"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
        releaseDate <- map["release_date"]
        popularity <- map["popularity"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        adult <- map["adult"]
    }
}
