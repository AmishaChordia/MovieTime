//
//  NetworkManager+Movies.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation
extension NetworkManager {
    
    func fetchMovieSynopsis(movieId: String,
                            success: @escaping ((MovieSynopsis) -> Void),
                            failure: @escaping ((Error) -> Void)) {
        
        let request = FetchMovieSynopsisRequest(movieId: movieId)
        let parseBlock: ParseBlock = { (json: Data) -> Any? in
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(MovieSynopsis.self, from: json)
            }
            catch {
                print(error.localizedDescription)
                return error
            }
        }
        
        execute(request: request, parseBlock: parseBlock, success: { (result) in
            if let resultValue = result as? MovieSynopsis {
                success(resultValue)
            } else {
                print("parse error")
                failure(ErrorManager.error(code: 1001, errorDescription: Constants.ErrorKeys.dataParsingError))
            }
        }, failure: failure)
    }
    
    func fetchMovieReviews(movieId: String,
                           success: @escaping (([MovieReviewResult]) -> Void),
                           failure: @escaping ((Error) -> Void)) {
        
        let request = FetchMovieReviewsRequest(movieId: movieId)
        let parseBlock: ParseBlock = { (json: Data) -> Any? in
            let decoder = JSONDecoder()
            
            do {
                return try decoder.decode(MovieReview.self, from: json)
            }
            catch {
                print(error.localizedDescription)
                return error
            }
        }
        
        execute(request: request, parseBlock: parseBlock, success: { (result) in
            if let resultValue = result as? MovieReview {
                success(resultValue.results)
            } else {
                print("parse error")
                failure(ErrorManager.error(code: 1001, errorDescription: Constants.ErrorKeys.dataParsingError))
            }
        }, failure: failure)
    }
    
    func fetchSimilarMovies(movieId: String,
                            success: @escaping ((([Movie])) -> Void),
                            failure: @escaping ((Error) -> Void)) {
        
        let request = FetchSimilarMovieRequest(movieId: movieId)
        let parseBlock: ParseBlock = { (jsonData: Data) -> Any? in
            let decoder = JSONDecoder()
            
            do {
                return try decoder.decode(MovieResult.self, from: jsonData)
            }
            catch {
                print(error.localizedDescription)
                return error
            }
        }
        
        execute(request: request, parseBlock: parseBlock, success: { (result) in
            if let resultValue = result as? MovieResult {
                success(resultValue.results)
            } else {
                print("parse error")
                failure(ErrorManager.error(code: 1001, errorDescription: Constants.ErrorKeys.dataParsingError))
            }
        }, failure: failure)
    }
    
    func fetchMovieCredits(movieId: String,
                           success: @escaping (([MovieCast]) -> Void),
                           failure: @escaping ((Error) -> Void)) {
        
        let request = FetchMovieCreditsRequest(movieId: movieId)
        let parseBlock: ParseBlock = { (json: Data) -> Any? in
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(MovieCredits.self, from: json)
            }
            catch {
                print(error.localizedDescription)
                return error
            }
        }
        
        execute(request: request, parseBlock: parseBlock, success: { (result) in
            if let resultValue = result as? MovieCredits {
                success(resultValue.cast)
            } else {
                print("parse error")
                failure(ErrorManager.error(code: 1001, errorDescription: Constants.ErrorKeys.dataParsingError))
            }
        }, failure: failure)
    }
    
    func fetchPlayingNowMovies(success: @escaping (([Movie]) -> Void),
                               failure: @escaping ((Error) -> Void)) {
        
        let request = FetchNowPlayingMovieRequest()
        
        let parseBlock: ParseBlock = { (jsonData: Data) -> Any? in
            let decoder = JSONDecoder()
            
            do {
                return try decoder.decode(MovieResult.self, from: jsonData)
            }
            catch {
                print(error.localizedDescription)
                return error
            }
        }
        
        execute(request: request, parseBlock: parseBlock, success: { (result) in
            if let resultValue = result as? MovieResult {
                success(resultValue.results)
            } else {
                print("parse error")
                failure(ErrorManager.error(code: 1001, errorDescription: Constants.ErrorKeys.dataParsingError))
            }
        }, failure: failure)
    }
}
