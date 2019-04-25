//
//  MoviesViewController.swift
//  PopularMovies
//
//  Created by jets on 7/27/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

private let reuseIdentifier = "MovieCell"
private let movieDetailsStoryboardId = "movieDetailsVC_ID"
private let API_Call = NetworkingClient.instance
private var moviesResponse: [[String: Any]]!
private var moviesList: [MovieDTO] = []
private var moviesSortType: String = API_Call.MOVIES_POPULARITY_SORT
private var isChangeOrderClicked: Bool = true
private var movieDetailsViewController: MovieDetailsViewController!
private var isNetworkAvailable: Bool!
private var coreDataHandler: CoreDataHandler!

class MoviesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {


    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()");
        isNetworkAvailable = Utility.isConnectedToNetwork();
        
        // Core Data Handler Object Initialization
        coreDataHandler = CoreDataHandler();
        
        movieDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: movieDetailsStoryboardId) as! MovieDetailsViewController
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear()");
        fetchMovies();
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 8
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        let row: Int = indexPath.row
        
        if let posterPath = moviesList[row].posterPath {
            let imageURL = Constants.IMAGES_BASE_URL + Constants.IMAGE_SIZE_185 + posterPath
            cell.movieImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: ""))
        }
    
        // set Cell attributes
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieDetailsViewController.movie = moviesList[indexPath.row]
        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }

    
    @IBAction func popularOrderBtn(_ sender: Any) {
        clearCollectionView()
        moviesSortType = API_Call.MOVIES_POPULARITY_SORT
        isChangeOrderClicked = true
        fetchMovies()
    }
    @IBAction func topRateOrderBtn(_ sender: Any) {
        clearCollectionView()
        moviesSortType = API_Call.MOVIES_HIGHEST_RATED_SORT
        isChangeOrderClicked = false
        fetchMovies()
    }
    
    private func fetchMovies() {
        let _ = API_Call.getMovies(sortType: moviesSortType).then {
            movies -> Void in
            moviesList = movies
            self.collectionView?.reloadData();
            }.catch {
                error -> Void in
        }
    }
    
    private func clearCollectionView() {
        moviesList.removeAll();
        self.collectionView?.reloadData()
    }
    
    private func addMovie(_ movie: MovieDTO) {
        moviesList.append(movie)
        self.collectionView?.reloadData()
    }
    
}
