//
//  DashboardViewController.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    struct DashboardConstants {
        static let collectionCellPadding: CGFloat = 10
        static let collectionCellHeight: CGFloat = 280
        static let imageUrlPath = NetworkManager.shared.imageBaseUrl + Constants.ImageDimension.small
    }
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dashboardViewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashboardViewModel.delegate = self
        dashboardViewModel.fetchPlayingNowMovies()
        setupView()
    }
    
    func setupView() {
        searchView.layer.cornerRadius = Constants.SearchBarConstants.searchBarHeight/2
        searchView.layer.borderWidth = Constants.SearchBarConstants.searchBarBorderWidth
        searchView.layer.borderColor = UIColor.searchBarBorder().cgColor
    }
    
    @IBAction func didTapSearchBar(_ sender: UIButton) {
        if let searchViewController = ViewControllerFactory.getSearchMovieViewController(movieList: dashboardViewModel.getPlayingNowMovies()) {
            navigationController?.pushViewController(searchViewController, animated: true)
        }
    }
}

extension DashboardViewController: DashboardViewModelProtocol {
    func didFetchPlayingNowMoviesSuccessfully() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailFetchingPlayingNowMovies(error: Error) {
        print(error)
        // Handle Error/ Retry
    }
}

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardViewModel.getPlayingNowMovies().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashboardMovieCollectionViewCell.reuseIdentifier, for: indexPath) as? DashboardMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = dashboardViewModel.getPlayingNowMovies()[indexPath.item]
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

extension DashboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailViewController = ViewControllerFactory.getMovieDetailViewController(movieId: String(dashboardViewModel.getPlayingNowMovies()[indexPath.item].id)) {
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
