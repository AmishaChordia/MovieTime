//
//  DashboardMovieCollectionViewCell.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 29/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit
import SDWebImage

final class DashboardMovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DashboardMovieCollectionViewCell"
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieStarRatingImageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitleLabel.text = nil
        releaseDateLabel.text = nil
        ratingLabel.text = nil
        movieImageView.image = nil
        movieStarRatingImageView.image = nil

    }
    
    func setInfo(title: String, date: String, rating: Double?, imagePath: String) {
        movieTitleLabel.text = title
        releaseDateLabel.text = date
        if let rating = rating {
            movieStarRatingImageView.image = UIImage(named: "img_star")
            ratingLabel.text = "\(rating)"
        }
        else {
            movieStarRatingImageView.image = nil
            ratingLabel.text = nil
        }
        movieImageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder.png"))
    }
}
