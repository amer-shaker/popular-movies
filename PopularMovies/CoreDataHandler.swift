//
//  CoreDataHandler.swift
//  PopularMovies
//
//  Created by jets on 8/1/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler {
    
    let appDelegate: AppDelegate!;
    let managedObjectContext: NSManagedObjectContext!;
    
    init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate;
        managedObjectContext = appDelegate.persistentContainer.viewContext;
    }
    
    func saveMovie(movieDTO movie: MovieDTO) -> Bool {
        
        if searchMovie(MovieDTO: movie) {
        
        let movieEntity: NSEntityDescription = NSEntityDescription.entity(forEntityName: Constants.MOVIE_ENTITY, in: managedObjectContext)!;
        let movieNSManagedObject: NSManagedObject = NSManagedObject(entity: movieEntity, insertInto: managedObjectContext);
        
        movieNSManagedObject.setValue(movie.id, forKey: "id")
        movieNSManagedObject.setValue(movie.title, forKey: "title")
        movieNSManagedObject.setValue(movie.originalTitle, forKey: "originalTitle")
        movieNSManagedObject.setValue(movie.originalLanguage, forKey: "originalLanguage")
        movieNSManagedObject.setValue(movie.overview, forKey: "overview")
        movieNSManagedObject.setValue(movie.posterPath, forKey: "posterPath")
        movieNSManagedObject.setValue(movie.backdropPath, forKey: "backdropPath")
        movieNSManagedObject.setValue(movie.releaseDate, forKey: "releaseDate")
        movieNSManagedObject.setValue(movie.popularity, forKey: "popularity")
        movieNSManagedObject.setValue(movie.voteAverage, forKey: "voteAverage")
        movieNSManagedObject.setValue(movie.voteCount, forKey: "voteCount")
        movieNSManagedObject.setValue(movie.adult, forKey: "adult")
        movieNSManagedObject.setValue(movie.trailers, forKey: "trailers")
        movieNSManagedObject.setValue(movie.reviews, forKey: "reviews")

        do {
            try managedObjectContext.save()
            print("Data Saved Successfully.")
        } catch let error as NSError {
            print(error);
            return false;
        }
        
        return true;
    } else{
    
    return false;
    }
}

     func searchMovie(MovieDTO movie: MovieDTO) -> Bool{
        let movieFetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.MOVIE_ENTITY);
        movieFetchRequest.predicate = NSPredicate(format:"id = %i", movie.id!)
        movieFetchRequest.includesSubentities = false
    
        var numberCount = 0
    
    do {
        numberCount = try managedObjectContext.count(for:movieFetchRequest)
        
          if numberCount < 1
          {
            return true;
          }
        
        } catch {
           print("search error");
        }
    
        return false;
    }
    
    func deleteMovie(movieDTO movie: MovieDTO)->Bool{
        
        let movieFetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.MOVIE_ENTITY);
        movieFetchRequest.predicate = NSPredicate(format:"id = %i", movie.id!)
        movieFetchRequest.includesSubentities = false
        
        
        do {
            let movies = try managedObjectContext.fetch(movieFetchRequest)
            
            if movies.count > 0 {
                
              for movie in movies {
                 managedObjectContext!.delete(movie)
              }
                return true;
            }
        
        } catch {
            print("delete error");
        }
        
        return false;
    }

    func getMovies() -> Array<MovieDTO> {
        var moviesList: Array<MovieDTO> = [];
        
        let moviesFetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.MOVIE_ENTITY);
        
        do {
            let movies = try managedObjectContext.fetch(moviesFetchRequest);
            
            // Add Movie Object to MoviesList
            for movie in movies {
                let movieDTO: MovieDTO = MovieDTO();
                
                movieDTO.id = movie.value(forKey: "id") as? Int
                movieDTO.title = movie.value(forKey: "title") as? String
                movieDTO.originalTitle = movie.value(forKey: "originalTitle") as? String
                movieDTO.originalLanguage = movie.value(forKey: "originalLanguage") as? String
                movieDTO.overview = movie.value(forKey: "overview") as? String
                movieDTO.posterPath = movie.value(forKey: "posterPath") as? String
                movieDTO.backdropPath = movie.value(forKey: "backdropPath") as? String
                movieDTO.releaseDate = movie.value(forKey: "releaseDate") as? String
                movieDTO.popularity = movie.value(forKey: "popularity") as? Double
                movieDTO.voteAverage = movie.value(forKey: "voteAverage") as? Double
                movieDTO.voteCount = movie.value(forKey: "voteCount") as? Int
                movieDTO.adult = movie.value(forKey: "adult") as? Bool
                movieDTO.trailers = movie.value(forKey: "trailers") as! [TrailerDTO]
                movieDTO.reviews = movie.value(forKey: "reviews") as! [ReviewDTO]
                
                moviesList.append(movieDTO);
            }
            
        } catch let error as NSError {
            print(error);
        }
        
        return moviesList;
    }
}
