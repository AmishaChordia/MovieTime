//
//  MovieReview.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

struct MovieReview: Codable {
    let id: Int
    let page: Int
    let result: [MovieReviewResult]
}

struct MovieReviewResult: Codable {
    let author: String
    let content: String
}

