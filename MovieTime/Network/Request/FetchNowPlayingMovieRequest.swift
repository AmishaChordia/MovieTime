//
//  FetchNowPlayingMovieRequest.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

struct FetchNowPlayingMovieRequest: NetworkRequestConvertible {
    
    /// String instance
    let urlString: String
    
    /// Initializer for the request type with provided inputs
    ///
    /// - Parameters:
    ///   - baseURL: String - Base URL of the request
    init() {
        urlString = NetworkManager.shared.baseUrl + NetworkRequestType.moviesPlayingNow.urlPath
    }
}
