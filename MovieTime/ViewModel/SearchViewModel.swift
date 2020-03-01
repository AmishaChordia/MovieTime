//
//  SearchViewModel.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

protocol SearchViewModelProtocol: class {
    func reloadTableView()
}

final class SearchViewModel {

    weak var delegate: SearchViewModelProtocol?

    private let trieMapping = SearchAutoComplete()
    private(set) var tableDataSource = [MovieSearchResultType]() {
        didSet {
            delegate?.reloadTableView()
        }
    }
    
    var movieList = [Movie]() {
        didSet {
            let movieTitles = movieList.map({ $0.title })
            trieMapping.createPhraseToNodeMappings(phrases: movieTitles)
        }
    }
    
    init() {}
    
    func updateRecentSearchedMovies() {
        var recents = [MovieSearchResultType]()
        if let recentMovieIds = UserDefaults.standard.value(forKey: Constants.RecentSearches.recentSearchKey) as? [Int] {
            recentMovieIds.forEach { (id) in
                if let movie = movieList.first(where: { $0.id == id }) {
                    recents.append(movie)
                }
            }
        }
        tableDataSource = recents.reversed()
    }
    
    func setRecentSearchMovie(movie: MovieSearchResultType) {
        if var recentMovieIds = UserDefaults.standard.value(forKey: Constants.RecentSearches.recentSearchKey) as? [Int] {
            recentMovieIds.removeAll(where: { $0 == movie.id })
            recentMovieIds.append(movie.id)

            if recentMovieIds.count > Constants.RecentSearches.maxRecentSaves {
                recentMovieIds = Array(recentMovieIds[1..<6])
            }
            UserDefaults.standard.set(recentMovieIds, forKey: Constants.RecentSearches.recentSearchKey)
        }
        else {
            UserDefaults.standard.set([movie.id], forKey: Constants.RecentSearches.recentSearchKey)
        }
        updateRecentSearchedMovies()
    }
    
    func updateSearchResults(searchString: String) {
        let searchText = searchString.lowercased()
        let tokenizedSententce = searchText.split(separator: " ")
        var associatedItems: [Int]?
        
        for word in tokenizedSententce {
            let currentAssociatedItemList = traverseWord(searchString: String(word))
            if currentAssociatedItemList.isEmpty {
                associatedItems = []
                break
            }
            
            if associatedItems == nil {
                associatedItems = currentAssociatedItemList
            }
            
            associatedItems = Array(Set(associatedItems ?? []).intersection(Set(currentAssociatedItemList)))
        }
        
        // Re-map to movies
        var searchFilteredMovies = [MovieSearchResultType]()
        associatedItems?.forEach { (itemIndex) in
            searchFilteredMovies.append(movieList[itemIndex])
        }
        
        tableDataSource = searchFilteredMovies
    }
    
    
    /// Traverse each word to find associated movie names
    /// - Parameter searchString: Word ex- "Dil" "Pagal"
    private func traverseWord(searchString: String) -> [Int] {
        var prevNode: Node?
        var associatedItems = [Int]()
        
        for (index, searchCharacter) in searchString.enumerated() {
            let currentCharacter = String(searchCharacter)
            
            if index == 0 {
                if let rootNode = trieMapping.nodeLookUpTable[currentCharacter] {
                    associatedItems = rootNode.associatedItems
                    prevNode = rootNode
                }
                else {
                    // No such root found, so not a valid word to search
                    print("No such root found, so not a valid word to search")
                    return []
                }
            }
            else {
                let child = prevNode?.children.first(where: ({ $0.value == currentCharacter }))
                
                if let childNode = child {
                    associatedItems = childNode.associatedItems
                    prevNode = child
                }
                else {
                    print("No such child of prev node")
                    // No such child of prev node
                    return []
                }
            }
        }
        return associatedItems
    }
}
