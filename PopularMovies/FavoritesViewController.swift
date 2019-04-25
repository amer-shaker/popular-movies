//
//  FavoritesViewController.swift
//  PopularMovies
//
//  Created by jets on 7/30/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

private var moviesList: [MovieDTO] = []
private let API_Call = NetworkingClient.instance
private var coreDataHandler: CoreDataHandler!
private let movieDetailsStoryboardId = "movieDetailsVC_ID"
private var movieDetailsViewController: MovieDetailsViewController!

class FavoritesViewController: UITableViewController, FavoriteMovieDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataHandler = CoreDataHandler()
        movieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: movieDetailsStoryboardId) as! MovieDetailsViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moviesList = coreDataHandler.getMovies()
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! FavoriteMovieCell
        let movie: MovieDTO = moviesList[indexPath.row]
        
        let posterPath = movie.posterPath
        
        if (posterPath != nil) {
            let imageURL = Constants.IMAGES_BASE_URL + Constants.IMAGE_SIZE_185 + posterPath!
            cell.movieImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: ""))
        }
        
        cell.titleLabel.text = movie.title!
        cell.releaseDateLabel.text = movie.releaseDate!
        
        if (movie.voteAverage != nil) {
            cell.voteAverageCosmosView.rating = (movie.voteAverage! / 2.0)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieDetailsViewController.movie = moviesList[indexPath.row]
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func addToFavorite(movie: MovieDTO) {
        moviesList.append(movie)
        self.tableView.reloadData()
    }
    
}
