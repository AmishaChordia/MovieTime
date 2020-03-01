//
//  ViewControllerFactory.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

struct ViewControllerFactory {
    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func getMovieDetailViewController(movieId: String) -> MovieDetailViewController? {
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController
        detailViewController?.movieId = String(movieId)
        return detailViewController
    }
    
    static func getSearchMovieViewController(movieList: [Movie]) -> SearchMovieViewController? {
        let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchMovieViewController") as? SearchMovieViewController
        searchViewController?.allMovieList = movieList
        return searchViewController
    }
}
