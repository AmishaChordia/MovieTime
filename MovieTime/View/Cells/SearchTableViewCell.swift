//
//  SearchTableViewCell.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SearchTableViewCell"

    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        releaseDateLabel.text = nil
        movieTitleLabel.text = nil
    }

    func setupView(title: String, date: String?) {
        releaseDateLabel.text = date
        movieTitleLabel.text = title
    }
}
