//
//  NetworkRequestConvertible.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Alamofire

/// Delegate for specifying network request details for implementing class
public protocol NetworkRequestConvertible {
    
    // MARK: - Variables
    
    /// URL string to be appended to base URL
    var urlString: String { get }
    
    // MARK: - Protocol Functions
    
    /// Initializes the http method to apply to a `URLRequest`.
    ///
    /// - Returns: The adapted `HTTPMethod`.
    func httpMethod() -> HTTPMethod
    
    /// Function for specify additional parameters
    ///
    /// - Returns: Dictionary of parameters to apply to a `URLRequest`
    func parameters() -> Parameters?
    
    /// Function to specify parameter encoding (way in which parameters should be sent in the request)
    ///
    /// - Returns: Type used to define how a set of parameters are applied to a `URLRequest`.
    func parameterEncoding() -> ParameterEncoding
}

// MARK: - Protocol Default Implementation
public extension NetworkRequestConvertible {
    /// Default definition for Http function
    func httpMethod() -> HTTPMethod {
        return .get
    }
    
    /// Default definition for parameterEncoding() function
    func parameterEncoding() -> ParameterEncoding {
        return URLEncoding.queryString
    }

    /// Default definition for parameters() function
    func parameters() -> Parameters? {
        return [Constants.NetworkKeys.apiKey: NetworkManager.shared.apiKey]
    }
}
