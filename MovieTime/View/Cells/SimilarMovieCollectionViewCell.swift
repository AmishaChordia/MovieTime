//
//  SimilarMovieCollectionViewCell.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit
import SDWebImage

final class SimilarMovieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "SimilarMovieCollectionViewCell"

    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    var dataSource: [(imageUrl: String, title: String)] = []
    
    func setupView(similarMovies: [(imageUrl: String, title: String)]) {
        dataSource = similarMovies
        horizontalCollectionView.reloadData()
    }
}

extension SimilarMovieCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movieInfo = dataSource[indexPath.item]
        cell.setUpView(movieUrl: movieInfo.imageUrl, title: movieInfo.title)
        return cell
    }
}

final class MovieCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MovieCollectionViewCell"

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieTitleLabel.text = nil
        movieImageView.image = nil
        movieImageView.layer.cornerRadius = 10
    }
    
    func setUpView(movieUrl: String, title: String) {
        movieTitleLabel.text = title
        movieImageView.sd_setImage(with: URL(string: movieUrl), placeholderImage: nil)
    }
}
