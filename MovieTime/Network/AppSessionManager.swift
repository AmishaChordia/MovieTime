//
//  AppSessionManager.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Alamofire

/// Session for all `URLRequest` in the application.
let AppSession: SessionManager = {
    
    // Background session
    let configuration = URLSessionConfiguration.background(withIdentifier: Constants.NetworkKeys.networkSessionIdentifier)
    
    // Turn-off caching
    configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    configuration.urlCache = nil
    
    // Request Time-out
    configuration.timeoutIntervalForRequest = Constants.NetworkKeys.networkTimeout
    
    // Set service type
    configuration.isDiscretionary = false
    configuration.networkServiceType = .responsiveData
    
    // Create session
    let session = Alamofire.SessionManager(configuration: configuration)
    return session
}()
