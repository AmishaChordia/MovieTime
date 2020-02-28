//
//  ErrorManager.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

final class ErrorManager {
    
    static func error(domain: String? = nil, code: Int, errorDescription: String) -> Error {
        let userInfo = [NSLocalizedDescriptionKey: errorDescription]
        return NSError(domain: domain ?? Constants.ErrorKeys.errorDomain, code: code, userInfo: userInfo)
    }
}
