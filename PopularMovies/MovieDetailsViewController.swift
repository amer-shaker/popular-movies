//
//  MovieDetailsViewController.swift
//  PopularMovies
//
//  Created by jets on 7/29/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import UIKit
import Cosmos

private let API_Call = NetworkingClient.instance
private var coreDataHandler: CoreDataHandler!

class MovieDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var overviewTextField: UITextView!
    @IBOutlet weak var trailersCollectionView: UICollectionView!
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var favBtn: UIButton!
    
    // MARK: Data
    var movie: MovieDTO?
    var favButtonFlag = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataHandler = CoreDataHandler()
        self.reviewsTableView.rowHeight = UITableViewAutomaticDimension
        self.reviewsTableView.estimatedRowHeight = 100
        
        self.reviewsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let imageURL = Constants.IMAGES_BASE_URL + Constants.IMAGE_SIZE_185 + (movie!.posterPath ?? "")
        moviePoster.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: ""))
        movieTitle.text = movie?.title
        releaseYear.text = movie?.releaseDate
        overviewTextField.text = movie?.overview
        ratingView.isUserInteractionEnabled = false
        
        let isSuccess: Bool = coreDataHandler.searchMovie(MovieDTO: movie!)
        if (isSuccess) {
            favBtn.setImage(UIImage(named:"heart-5.png"), for: .normal)
            favButtonFlag = 0
        }else{
            favBtn.setImage(UIImage(named:"favorite-heart-button.png"), for: .normal)
            favButtonFlag = 1
        }
        
        fetchTrailers()
        fetchReviews()
    }
    
    private func fetchTrailers() {
        let _ = API_Call.getTrailers(movieId: movie?.id ?? 0).then {
            trailers -> Void in
            self.movie?.trailers = trailers
            self.trailersCollectionView.reloadData()
            }.catch {
                error -> Void in
        }
    }
    
    private func fetchReviews() {
        let _ = API_Call.getReviews(movieId: movie?.id ?? 0).then {
            reviews -> Void in
            self.movie?.reviews = reviews
            self.reviewsTableView.reloadData()
            }.catch {
                error -> Void in
        }
    }

    // Add the movie to core data
    @IBAction func addToFavorites(_ sender: Any) {
        if favButtonFlag == 0 {
           let isSuccess: Bool = coreDataHandler.saveMovie(movieDTO: movie!)
           if (isSuccess) {
            (sender as AnyObject).setImage(UIImage(named:"favorite-heart-button.png"), for: .normal)
           }
            
           favButtonFlag = 1
        } else{
            let isSuccess: Bool = coreDataHandler.deleteMovie(movieDTO: movie!)
            if (isSuccess) {
                (sender as AnyObject).setImage(UIImage(named:"heart-5.png"), for: .normal)
            }
            
            favButtonFlag = 0
        }
    }
    
    private func showAlert() {
        // create the alert
        let alert = UIAlertController(title: "Favorites", message: "Successfully, added to favorites", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}


// Trailers
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return (movie?.trailers.count)!
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.SHOW_MOVIE_COLLECTION_VIEW_ID, for: indexPath) as! TrailerCollectionViewCell
        
        cell.trailerLabel.text = movie?.trailers[indexPath.row].name ?? ""
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: "http://youtube.com/watch?v=\((movie?.trailers[indexPath.row].key)!)"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

// Reviews
extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (movie?.reviews)!.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as!ReviewTableViewCell
        
        let movieReview = movie?.reviews[indexPath.row]
        
        // Bind data to review cell
        cell.authorLabel.text = movieReview?.author
        cell.contentLabel.text = movieReview?.content
        
        return cell
    }
}
