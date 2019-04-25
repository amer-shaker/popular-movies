//
//  NetworkingClient.swift
//  PopularMovies
//
//  Created by jets on 7/27/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class NetworkingClient {
    
    static let instance = NetworkingClient()
    let MOVIES_POPULARITY_SORT = "popularity"
    let MOVIES_HIGHEST_RATED_SORT = "top_rated"
    
    private init() {
    
    }
    
    
    func getMovies(sortType: String) -> Promise<[MovieDTO]> {
        
        let MOVIES_URL: String = self.buildMoviesURL(sortBy: sortType)
        
        return Promise<[MovieDTO]> { (fulfilled, reject) -> Void in
            
            return Alamofire.request(MOVIES_URL).responseString{(response) in
                
                switch(response.result) {
                    case .success(let reponseString):
                        let moviesReponse = MovieAPIResponse(JSONString: "\(reponseString)");
                        fulfilled((moviesReponse?.movies!)!)
                    case .failure(let error):
                        print(error)
                        reject(error)
                }
            }
        }
    }
    
    func getTrailers(movieId: Int) -> Promise<[TrailerDTO]> {
        
        let TRAILERS_URL: String = Constants.TRAILERS_BASE_URL + String(movieId) + Constants.TRAILERS_MOVIE_ID + Constants.API_KEY

        return Promise<[TrailerDTO]> { (fulfilled, reject) -> Void in
            
            return Alamofire.request(TRAILERS_URL).responseString{(response) in
                
                switch(response.result) {
                case .success(let reponseString):
                   let trailersReponse = TrailerAPIResponse(JSONString: "\(reponseString)");
                    fulfilled((trailersReponse?.trailers!)!)
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            }
        }
    }

    func getReviews(movieId: Int) -> Promise<[ReviewDTO]> {
        
        let REVIEWS_URL: String = Constants.REVIEWS_BASE_URL + String(movieId) + Constants.REVIEWS_MOVIE_ID + Constants.API_KEY
        
        return Promise<[ReviewDTO]> { (fulfilled, reject) -> Void in
            
            return Alamofire.request(REVIEWS_URL).responseString{(response) in
                
                switch(response.result) {
                case .success(let reponseString):
                    let reviewsReponse = ReviewAPIResponse(JSONString: "\(reponseString)");
                    fulfilled((reviewsReponse?.reviews!)!)
                case .failure(let error):
                    print(error)
                    reject(error)
                }
            }
        }
    }
    
    private func buildMoviesURL(sortBy sortType: String) -> String {
        if (sortType == MOVIES_POPULARITY_SORT) {
            return Constants.MOVIES_BASE_URL + Constants.MOVIES_SORT_BY_POPULARITY + Constants.API_KEY
        } else {
            return Constants.MOVIES_BASE_URL + Constants.MOVIES_SORT_BY_TOP_RATED + Constants.API_KEY
        }
    }
    
}
