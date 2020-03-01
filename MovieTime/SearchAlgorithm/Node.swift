//
//  Node.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 01/03/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

import Foundation

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

