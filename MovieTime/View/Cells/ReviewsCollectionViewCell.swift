//
//  ReviewsCollectionViewCell.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ReviewsCollectionViewCell"

       @IBOutlet weak var horizontalCollectionView: UICollectionView!
       var dataSource: [(review: String, author: String)] = []
       
       func setupView(reviews: [(review: String, author: String)]) {
           dataSource = reviews
           horizontalCollectionView.reloadData()
       }
}

extension ReviewsCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? ReviewDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let reviewInfo = dataSource[indexPath.item]
        cell.setUpView(author: reviewInfo.author, review: reviewInfo.review)
        return cell
    }
}

final class ReviewDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var reviewLabel: UILabel?
    @IBOutlet weak var authorLabel: UILabel?

    
    static let reuseIdentifier = "ReviewDetailCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        authorLabel?.text = nil
        reviewLabel?.text = nil
        contentView.layer.cornerRadius = 10
    }
    
    func setUpView(author: String, review: String) {
        reviewLabel?.text = review
        authorLabel?.text = author
    }
}
