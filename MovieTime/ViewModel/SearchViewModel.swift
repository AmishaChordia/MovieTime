//
//  SearchViewModel.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

protocol SearchViewModelProtocol: class {
    func someMethod()
}
final class SearchViewModel {
    var movieList = [Movie]()
    weak var delegate: SearchViewModelProtocol?
    
    init() {}
}
