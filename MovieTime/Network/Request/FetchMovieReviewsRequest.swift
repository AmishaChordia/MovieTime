//
//  FetchMovieReviewsRequest.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

/// Class specifies the main request parameter and body
struct FetchMovieReviewsRequest: NetworkRequestConvertible {
    
    /// String instance
    let urlString: String
    
    /// Initializer for the request type with provided inputs
    ///
    /// - Parameters:
    ///   - baseURL: String - Base URL of the request
    ///   - movieId: id of the resource
    init(movieId: String) {
        urlString = NetworkManager.shared.baseUrl + String(format: NetworkRequestType.movieReviews.urlPath, movieId)
    }
}
