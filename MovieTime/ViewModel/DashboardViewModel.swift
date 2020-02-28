//
//  DashboardViewModel.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 29/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

protocol DashboardViewModelProtocol: class {
    func didFetchPlayingNowMovies(movieList: [Movie])
    func didFailFetchingPlayingNowMovies(error: Error)
}

class DashboardViewModel {
    
    weak var delegate: DashboardViewModelProtocol?
    
    init() {}
    
    func getPlayingNowMovies() {
        NetworkManager().fetchPlayingNowMovies(success: { [weak self] (movies) in
            self?.delegate?.didFetchPlayingNowMovies(movieList: movies)
        }) { [weak self] (error) in
            self?.delegate?.didFailFetchingPlayingNowMovies(error: error)
        }
    }
}
