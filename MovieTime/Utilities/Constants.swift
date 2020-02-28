//
//  Constants.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//


public struct Constants {
    /// Constants for Network
    struct NetworkKeys {
        /// networkTimeout defines the timeout network requests creations in seconds
        static let networkTimeout: Double = 30
        static let networkSessionIdentifier = "network.alamofireBackgroundSessionIdentifier"
        static let apiKey = "api_key"
    }
    
    /// Constants for Error
    struct ErrorKeys {
        static let errorDomain = "error.movieTime.iOS"
        static let dataParsingError = "error.dataParsing"
        static let badResponse = "error.badResponse"
    }
}
