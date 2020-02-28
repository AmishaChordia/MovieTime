//
//  NetworkRequest.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Alamofire

/// Specifies network request and enqueues it for execution.
public final class NetworkRequest {
    
    /// Creates network request in the default session and enqueues it for execution.
    ///
    /// - Parameters:
    ///   - request: Struct specifying parameters required to configure `URLRequest`.
    ///   - success: If result returns the success then response object will be returned back in success block
    ///   - failure: If result returns the failure then Error will be returned back in failure block
    public static func execute(request: NetworkRequestConvertible, success: @escaping((Any) -> Void), failure: @escaping ((Error) -> Void)) {
        
        let networkRequest = AppSession.request(request.urlString,
                                                method: request.httpMethod(),
                                                parameters: request.parameters(),
                                                encoding: request.parameterEncoding())

        print("Firing Request - \(String(describing: networkRequest.request?.httpMethod)) URL : \(String(describing: networkRequest.request?.url))")

        networkRequest.validate(statusCode: 200..<400)
        networkRequest.responseJSON(options: .allowFragments) { (response) in
            
            print("Status code: \(response.response?.statusCode ?? 0)")
            
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    success(data)
                } catch {
                    failure(ErrorManager.error(code: 400, errorDescription: Constants.ErrorKeys.badResponse))
                }
                
            case .failure(let error):
                print("In Failure block - " + error.localizedDescription + "Status code: \(response.response?.statusCode ?? 0)")
                print("Response \(String(describing: response.data))")
                failure(error)
            }
        }
    }
}
