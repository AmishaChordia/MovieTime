//
//  DashboardViewController.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController {
    
    struct DashboardConstants {
        static let collectionCellPadding: CGFloat = 10
        static let collectionCellHeight: CGFloat = 280
        static let imageUrlPath = NetworkManager.shared.imageBaseUrl + Constants.ImageDimension.small
    }
        
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dashboardViewModel = DashboardViewModel()
    
    private var movieList = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashboardViewModel.delegate = self
        dashboardViewModel.getPlayingNowMovies()
        setupView()
    }
    
    func setupView() {
        searchView.layer.cornerRadius = Constants.SearchBarConstants.searchBarHeight/2
        searchView.layer.borderWidth = Constants.SearchBarConstants.searchBarBorderWidth
        searchView.layer.borderColor = UIColor.searchBarBorder().cgColor
    }
    
    @IBAction func didTapSearchBar(_ sender: UIButton) {
        print("search tapped")
    }
}

extension DashboardViewController: DashboardViewModelProtocol {
    func didFetchPlayingNowMovies(movieList: [Movie]) {
        self.movieList = movieList
    }
    
    func didFailFetchingPlayingNowMovies(error: Error) {
        print(error)
        // Handle Error/ Retry
    }
}

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardMovieCollectionViewCell.reuseIdentifier, for: indexPath) as? DashboardMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = movieList[indexPath.item]
        cell.setInfo(title: movie.title, date: movie.release_date, rating: movie.vote_average, imagePath: DashboardViewController.DashboardConstants.imageUrlPath + movie.poster_path)
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - DashboardConstants.collectionCellPadding)/2
        return CGSize(width: width, height: DashboardConstants.collectionCellHeight)
    }
}
