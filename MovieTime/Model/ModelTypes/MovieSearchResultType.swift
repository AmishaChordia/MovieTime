//
//  MovieSearchResultType.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

protocol MovieSearchResultType {
    var title: String { get }
    var formattedDate: String? { get }
    var id: Int { get }
}

extension Movie: MovieSearchResultType {
    var formattedDate: String? {
        return release_date?.formatDate()
    }
}
