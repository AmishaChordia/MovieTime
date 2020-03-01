//
//  MovieDetailViewModel.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 29/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol: class {
    // Reviews
    func didFinishFetchingReviews()
    func didFailFetchingReviews(error: Error)
    
    // Synopsis
    func didFinishFetchingSynopsis()
    func didFailFetchingSynopsis(error: Error)
    
    // Similar Movies
    func didFinishFetchingSimilarMovies()
    func didFailFetchingSimilarMovies(error: Error)
    
    // Credits
    func didFinishFetchingCredits()
    func didFailFetchingCredits(error: Error)
}

class MovieDetailViewModel {
    
    private var similarMovies = [Movie]()
    private var reviews = [MovieReviewResult]()
    private var cast = [MovieCast]()
    private var synopsis: MovieSynopsis?
    private let networkManager = NetworkManager.shared
    weak var delegate: MovieDetailViewModelProtocol?
    
    var movieIdentifier: String?
    
    init() {}
    
    func getSimilarMovies() -> [Movie] {
        return similarMovies
    }
    
    func getReviews() -> [MovieReviewResult] {
        return reviews
    }
    
    func getCast() -> [MovieCast] {
        return cast
    }
    
    func getSynopsis() -> MovieSynopsis? {
        guard let movieSynopsis = synopsis else {
            return nil
        }
        return movieSynopsis
    }
    
    func fetchSimilarMovies(movieId: String) {
        networkManager.fetchSimilarMovies(movieId: movieId, success: { [weak self] (movies) in
            self?.similarMovies = movies
            self?.delegate?.didFinishFetchingSimilarMovies()
        }) { [weak self] (error) in
            self?.delegate?.didFailFetchingSimilarMovies(error: error)
        }
    }
    
    func fetchReviews(movieId: String) {
        networkManager.fetchMovieReviews(movieId: movieId, success: { [weak self] (reviewArray) in
            self?.reviews = reviewArray
            self?.delegate?.didFinishFetchingReviews()
        }) { [weak self] (error) in
            self?.delegate?.didFailFetchingReviews(error: error)
        }
    }
        
    func fetchCast(movieId: String) {
        networkManager.fetchMovieCredits(movieId: movieId, success: { [weak self] (castArray) in
            self?.cast = castArray
            self?.delegate?.didFinishFetchingCredits()
        }) { [weak self] (error) in
            self?.delegate?.didFailFetchingCredits(error: error)
        }
    }
    
    func fetchSynopsis(movieId: String) {
        networkManager.fetchMovieSynopsis(movieId: movieId, success: { [weak self] (synopsis) in
            self?.synopsis = synopsis
            self?.delegate?.didFinishFetchingSynopsis()
        }) { [weak self] (error) in
            self?.delegate?.didFailFetchingSynopsis(error: error)
        }
    }
}
