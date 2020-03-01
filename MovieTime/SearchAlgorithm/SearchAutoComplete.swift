//
//  SearchAutoComplete.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

final class SearchAutoComplete {
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
                        
                        if let existingNode = prevNode?.children.first(where: { $0.value == nodeValue }) {
                            
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
}
