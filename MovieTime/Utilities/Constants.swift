//
//  Constants.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

public struct Constants {
    struct ImageDimension {
        static let small = "w200"
        static let large = "w500"
    }
    
    struct SearchBarConstants {
        static let searchBarHeight: CGFloat = 46.0
        static let searchBarBorderWidth: CGFloat = 0.5
    }
    
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
