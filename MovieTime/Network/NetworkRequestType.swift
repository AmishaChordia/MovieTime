//
//  NetworkRequestType.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

/// NetworkRequestType defines the different type of request
public enum NetworkRequestType {
    case moviesPlayingNow
    case movieReviews
    case movieCredits
    case similarMovies
    case movieSynopsis
    
    public var urlPath: String {
        switch self {
        case .moviesPlayingNow:
            return "now_playing"
        case .movieReviews:
            return "%@/reviews"
        case .movieCredits:
            return "%@/credits"
        case .similarMovies:
            return "%@/similar"
        case .movieSynopsis:
            return "%@"
        }
    }
}
