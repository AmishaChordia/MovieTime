//
//  MovieSynopsisCollectionViewCell.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

final class MovieSynopsisCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MovieSynopsisCollectionViewCell"

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitleLabel.text = nil
        releaseDateLabel.text = nil
        ratingLabel.text = nil
        movieDescriptionLabel.text = nil
        languageLabel.text = nil
    }
    
    func setView(rating: Double?, date: String, title: String, language: String?, descriptionText: String) {
        movieTitleLabel.text = title
        releaseDateLabel.text = date
        ratingLabel.text = "\(rating ?? 0)"
        movieDescriptionLabel.text = descriptionText
        languageLabel.text = language?.uppercased()
    }
}
