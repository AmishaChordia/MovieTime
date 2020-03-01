//
//  SearchMovieViewController.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTableHeaderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var allMovieList = [Movie]()
    let viewModel = SearchViewModel()
    var tableDataSource = [MovieSearchResultType]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.movieList = allMovieList
        viewModel.delegate = self
        searchTableHeaderLabel.text = nil
        setupTableView(searchString: "")
     }
     
     func setupView() {
         searchTextField.becomeFirstResponder()
         searchView.layer.cornerRadius = Constants.SearchBarConstants.searchBarHeight/2
         searchView.layer.borderWidth = Constants.SearchBarConstants.searchBarBorderWidth
         searchView.layer.borderColor = UIColor.searchBarBorder().cgColor
     }
    
    @IBAction func didSelectBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeSearchTextFieldValue(_ sender: UITextField) {
        print(sender.text ?? "")
        setupTableView(searchString: sender.text ?? "")
    }
    
    func setupTableView(searchString: String) {
        if searchString.isEmpty {
            // show recent movies
            tableDataSource = viewModel.getRecentSearchedMovies()
            if !tableDataSource.isEmpty {
                searchTableHeaderLabel.text = "Recent Search"
            }
            else {
                searchTableHeaderLabel.text = nil
            }
        }
        else {
            // show search results
            tableDataSource = viewModel.getSearchResults(searchString: searchString)
            if !tableDataSource.isEmpty {
                searchTableHeaderLabel.text = "Search Results (\(tableDataSource.count))"
            }
            else {
                searchTableHeaderLabel.text = "No results found for \(searchString)"
            }
        }
    }
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell {
            let currentMovie = tableDataSource[indexPath.row]
            cell.setupView(title: currentMovie.title, date: currentMovie.release_date)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = tableDataSource[indexPath.row]
        viewModel.setRecentSearchMovie(movie: selectedMovie)
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            detailViewController.movieId = String(selectedMovie.id)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension SearchMovieViewController: SearchViewModelProtocol {
    func someMethod() {
        
    }
}
