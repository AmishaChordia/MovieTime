//
//  NetworkManager.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Alamofire

/// A custom parse block
public typealias ParseBlock = (Data) -> Any?

/// NetworkManager class for handling all Network related tasks
public class NetworkManager {
    
    /// Shared instance of Network Manager
    static public let shared = NetworkManager()
    
    // MARK: - Constants
    private(set) var baseUrl: String
    private(set) var imageBaseUrl: String
    private(set) var apiKey: String
    
    // MARK: - Initializer
    init() {
        self.imageBaseUrl = "https://image.tmdb.org/t/p/"
        self.baseUrl = "https://api.themoviedb.org/3/movie/"
        self.apiKey = "3298880137172cea814f46805f3df4fe"
    }
    
    // MARK: - User-defined Functions
    /// Generic Function to execute Network request.
    ///
    /// - Parameters:
    ///   - request: NetworkRequestConvertible request which is to be executed
    ///   - parseBlock: Block to specify to parse destination response object
    ///   - success: If executeRequest() function returns success then response object will be returned back in success block
    ///   - failure: If executeRequest() function returns failure then Error will be returned back in failure block
    public func execute(request: NetworkRequestConvertible,
                        parseBlock: @escaping (ParseBlock),
                        success: @escaping((Any) -> Void),
                        failure: @escaping ((Error) -> Void)) {
        
        NetworkRequest.execute(request: request, success: {(response) in
            if let parseResponse = response as? Data, let parsedResponse = parseBlock(parseResponse) {
                success(parsedResponse)
            } else {
                success(response)
            }
        }, failure: {(error) in
            failure(error)
        })
    }
}
