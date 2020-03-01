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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.movieList = allMovieList
        viewModel.delegate = self
        setupTableView(searchString: "")
    }
    
    private func setupView() {
        searchTextField.becomeFirstResponder()
        searchView.layer.cornerRadius = Constants.SearchBarConstants.searchBarHeight/2
        searchView.layer.borderWidth = Constants.SearchBarConstants.searchBarBorderWidth
        searchView.layer.borderColor = UIColor.searchBarBorder().cgColor
        searchTableHeaderLabel.text = nil
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func didSelectBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didChangeSearchTextFieldValue(_ sender: UITextField) {
        setupTableView(searchString: sender.text ?? "")
    }
    
    private func setupTableView(searchString: String) {
        if searchString.isEmpty {
            // show recent movies
            viewModel.updateRecentSearchedMovies()
            if !viewModel.tableDataSource.isEmpty {
                searchTableHeaderLabel.text = "Recent Search"
            }
            else {
                searchTableHeaderLabel.text = "No recent searches"
            }
        }
        else {
            // show search results
            viewModel.updateSearchResults(searchString: searchString)
            if !viewModel.tableDataSource.isEmpty {
                searchTableHeaderLabel.text = "Search Results (\(viewModel.tableDataSource.count))"
            }
            else {
                searchTableHeaderLabel.text = #""No results found for \#(searchString)""#
            }
        }
    }
}

extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as? SearchTableViewCell {
            let currentMovie = viewModel.tableDataSource[indexPath.row]
            cell.setupView(title: currentMovie.title, date: currentMovie.formattedDate)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.tableDataSource[indexPath.row]
        viewModel.setRecentSearchMovie(movie: selectedMovie)
        if let detailViewController = ViewControllerFactory.getMovieDetailViewController(movieId: String(selectedMovie.id)) {
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension SearchMovieViewController: SearchViewModelProtocol {
    func reloadTableView() {
        tableView.reloadData()
    }
}
