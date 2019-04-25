//
//  FavoriteMovieCell.swift
//  PopularMovies
//
//  Created by jets on 7/30/1440 AH.
//  Copyright © 1440 AH ITI. All rights reserved.
//

import UIKit
import Cosmos

class FavoriteMovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var voteAverageCosmosView: CosmosView!
    
}
