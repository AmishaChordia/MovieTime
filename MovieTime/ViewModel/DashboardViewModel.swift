//
//  DashboardViewModel.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 29/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

protocol DashboardViewModelProtocol: class {
    func didFetchPlayingNowMoviesSuccessfully()
    func didFailFetchingPlayingNowMovies(error: Error)
}

class DashboardViewModel {
    
    private var movieList = [Movie]()
    
    weak var delegate: DashboardViewModelProtocol?
    
    init() {}
    
    func getPlayingNowMovies() -> [Movie] {
        return movieList
    }
    
    func fetchPlayingNowMovies() {
        NetworkManager().fetchPlayingNowMovies(success: { [weak self] (movies) in
            self?.movieList = movies
            self?.delegate?.didFetchPlayingNowMoviesSuccessfully()
        }) { [weak self] (error) in
            self?.delegate?.didFailFetchingPlayingNowMovies(error: error)
        }
    }
}
