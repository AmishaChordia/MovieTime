//
//  Movie.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

struct MovieResult: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let vote_average: Double
    let id: Int
    let release_date: String?
    let title: String
    let backdrop_path: String
    let poster_path: String
}
