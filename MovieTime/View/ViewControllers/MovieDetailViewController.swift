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
    
    struct MovieDetailViewConstants {
        static let backdropUrlPath = NetworkManager.shared.imageBaseUrl + Constants.ImageDimension.large
        static let similarMovieUrlPath = NetworkManager.shared.imageBaseUrl + Constants.ImageDimension.small
        static let bookButtonReuseId = "BookButtonCell"
    }
    
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
            moviePosterImageView.sd_setImage(with: URL(string: MovieDetailViewConstants.backdropUrlPath + synopsis.backdrop_path), placeholderImage: nil)
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
        return MovieDetailRows.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rowType = MovieDetailRows(rawValue: indexPath.item)
        switch rowType {
        case .movieInfo:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieSynopsisCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieSynopsisCollectionViewCell {
                if let synopsis = viewModel.getSynopsis() {
                    cell.setView(rating: synopsis.vote_average, date: synopsis.release_date.formatDate(), title: synopsis.original_title, language: synopsis.original_language, descriptionText: synopsis.overview)
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
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCollectionViewCell.reuseIdentifier, for: indexPath) as? ReviewsCollectionViewCell {
                cell.setupView(reviews: viewModel.getReviews().map({ (reviews) -> (review: String, author: String) in
                    return (reviews.content, reviews.author)
                }))
                return cell
            }
            
        case .similarMovies:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.reuseIdentifier, for: indexPath) as? SimilarMovieCollectionViewCell {
                let similarMovies = viewModel.getSimilarMovies().map { (movie) -> (imageUrl: String, title: String) in
                    let movieImageUrl = MovieDetailViewConstants.similarMovieUrlPath + movie.poster_path
                    return (movieImageUrl, movie.title)
                }
                
                cell.setupView(similarMovies: similarMovies)
                return cell
            }
            
        case .bookButton:
            return collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailViewConstants.bookButtonReuseId, for: indexPath)
        }
        
        return UICollectionViewCell()
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rowType = MovieDetailRows(rawValue: indexPath.item)
        let width = collectionView.frame.size.width
        var height: CGFloat = 0.1
        
        switch rowType {
        case .movieInfo:
            height = 205
        case .cast:
            height = 110
        case .reviews:
            if !viewModel.getReviews().isEmpty {
                height = 230
            }
        case .similarMovies:
            if !viewModel.getSimilarMovies().isEmpty {
                height = 250
            }
        case .bookButton:
            height = 90
        case .none:
            break
        }
      
        return CGSize(width: width, height: height)
    }
}
