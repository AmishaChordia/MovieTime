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
   
    var mapping = SearchAutoComplete()
    weak var delegate: SearchViewModelProtocol?
    
    var movieList = [Movie]() {
        didSet {
            let movieTitles = movieList.map({ $0.title })
            mapping.createPhraseToNodeMappings(phrases: movieTitles)
        }
    }
    
    init() {}
    
    func getRecentSearchedMovies() -> [MovieSearchResultType] {
        return UserDefaults.standard.value(forKey: Constants.RecentSearches.recentSearchKey) as? [MovieSearchResultType] ?? []
    }
    
    func setRecentSearchMovie(movie: MovieSearchResultType) {
        if var recents = UserDefaults.standard.value(forKey: Constants.RecentSearches.recentSearchKey) as? [MovieSearchResultType] {
            recents.append(movie)
            UserDefaults.standard.set(recents, forKey: Constants.RecentSearches.recentSearchKey)
        }
    }
    
    func getSearchResults(searchString: String) -> [MovieSearchResultType] {
        
        
        
        return []
    }
}

class SearchAutoComplete {
    var nodeLookUpTable = [String: Node]() // {"h": Node(), b: Node() ...} - Root Nodes
    
    func createPhraseToNodeMappings(phrases: [String]) {
        
        for (itemIndex, phrase) in phrases.enumerated() {
            // phrase is "Dil Toh pagal hai"
            let currentPhrase = phrase.lowercased()
            
            // wordEmbeddings is "Dil" "Toh" "Pagal"
            let wordEmbeddings = Array(currentPhrase.split(separator: " "))
            
            for word in wordEmbeddings {
                // word is  "Dil"
                
                var prevNode: Node?
                
                for (index, alphabet) in word.enumerated() {
                    let nodeValue = String(alphabet)
                    let isLastNode = index == word.count - 1

                    if index == 0 {
                        // This is Root Node "D"
                        if nodeLookUpTable[nodeValue] == nil {
                            
                            // This is new root node
                            let rootNode = Node(value: nodeValue, children: [], isLastNode: isLastNode, associatedItems: [itemIndex])
                            prevNode = rootNode
                            
                            // add to look up
                            nodeLookUpTable[nodeValue] = prevNode
                        }
                        else {
                            prevNode = nodeLookUpTable[nodeValue]
                            prevNode?.associatedItems.append(itemIndex)
                        }
                    }
                    else {
                        // not root node - "i" / "l"
                        // check if this was already a child of prev node
                        
                        if let existingNode = prevNode?.children.filter({ $0.value == nodeValue }).first {
                           // If YES, append associated item

                            existingNode.associatedItems.append(itemIndex)
                            prevNode = existingNode
                        }
                        else {
                            // add new child
                            let newNode = Node(value: nodeValue, children: [], isLastNode: isLastNode, associatedItems: [itemIndex])
                            prevNode?.children.append(newNode)
                            prevNode = newNode
                        }
                    }
                }
            }
        }
    }
    
    func logNode(node: Node) {
        print("************")
        print("Node value is \(node.value))")
        print("Children of \(node.value) are ..")
        print(node.children.map({ $0.value }))
        print("************")
      
        for child in node.children {
            logNode(node: child)
        }
    }
}

class Node {
    var value: String
    var children: [Node]
    var isLastNode: Bool
    var associatedItems: [Int]
    
    init(value: String, children: [Node], isLastNode: Bool, associatedItems: [Int]) {
        self.value = value
        self.children = children
        self.isLastNode = isLastNode
        self.associatedItems = associatedItems
    }
}

