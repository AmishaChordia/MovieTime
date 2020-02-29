//
//  MovieCastCollectionViewCell.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

final class MovieCastCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MovieCastCollectionViewCell"
    @IBOutlet weak var castInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castInfoLabel.text = nil
    }
    
    func setCastInfo(cast: [String]) {
        guard !cast.isEmpty else {
            return
        }
        castInfoLabel.text = cast.joined(separator: ", ")
    }
}
