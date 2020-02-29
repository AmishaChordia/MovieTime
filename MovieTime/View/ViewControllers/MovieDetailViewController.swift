//
//  MovieDetailViewController.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 29/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit
import SDWebImage

enum MovieDetailRows: Int, CaseIterable {
    case movieInfo
    case cast
    case reviews
    case similarMovies
    case bookButton
}

class MovieDetailViewController: UIViewController {

    // MARK - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    private var viewModel = MovieDetailViewModel()
    var movieId: String?

    @IBAction func didSelectback(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = movieId else {
            // Handle Error as per UX
            return
        }
        
        viewModel.delegate = self
        viewModel.movieIdentifier = movieId
        viewModel.fetchCast(movieId: id)
        viewModel.fetchReviews(movieId: id)
        viewModel.fetchSynopsis(movieId: id)
        viewModel.fetchSimilarMovies(movieId: id)
    }
}

extension MovieDetailViewController: MovieDetailViewModelProtocol {
    func didFinishFetchingReviews() {
        collectionView.reloadData()
    }
    
    func didFailFetchingReviews(error: Error) {
        // Handle/ retry error
    }
    
    func didFinishFetchingSynopsis() {
        if let synopsis = viewModel.getSynopsis() {
            let basePath = NetworkManager.shared.imageBaseUrl + Constants.ImageDimension.large
            moviePosterImageView.sd_setImage(with: URL(string: basePath + synopsis.backdrop_path), placeholderImage: UIImage(named: "placeholder.png"))
            collectionView.reloadData()
        }
    }
    
    func didFailFetchingSynopsis(error: Error) {
        // Handle/ retry error
    }
    
    func didFinishFetchingSimilarMovies() {
        collectionView.reloadData()
    }
    
    func didFailFetchingSimilarMovies(error: Error) {
        // Handle/ retry error
    }
    
    func didFinishFetchingCredits() {
        collectionView.reloadData()
    }
    
    func didFailFetchingCredits(error: Error) {
        // Handle/ retry error
    }
}


extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return MovieDetailRows.allCases.count
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowType = MovieDetailRows(rawValue: indexPath.item)
        switch rowType {
        case .movieInfo:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSynopsisCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieSynopsisCollectionViewCell {
                if let synopsis = viewModel.getSynopsis() {
                    cell.setView(rating: synopsis.vote_average, date: synopsis.release_date, title: synopsis.original_title, language: synopsis.original_language, descriptionText: synopsis.overview)
                }
                return cell
            }
            
        case .cast:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCastCollectionViewCell {
                cell.setCastInfo(cast: viewModel.getCast().map({ $0.name }))
                return cell
            }
        case .none:
            break
        case .reviews:
            break
        case .similarMovies:
            break
        case .bookButton:
            break
        }
        
        
        
        return UICollectionViewCell()
    }
}

extension MovieDetailViewController {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rowType = MovieDetailRows(rawValue: indexPath.item)
        let width = collectionView.frame.size.width
        var height: CGFloat = 0.1
        
        switch rowType {
        case .movieInfo:
            height = 215
        case .cast:
            height = 65
        case .none:
            break
        case .reviews:
            height = 214
        case .similarMovies:
            height = 250
        case .bookButton:
            height = 60
        }
      
        return CGSize(width: width, height: height)
    }
}
