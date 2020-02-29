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
    
    var movieList = [Movie]()
    
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.movieList = movieList
        viewModel.delegate = self
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
    }
}

extension SearchMovieViewController: SearchViewModelProtocol {
    func someMethod() {
        
    }
}
