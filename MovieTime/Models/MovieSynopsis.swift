//
//  MovieSynopsis.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

struct MovieSynopsis: Codable {
    let adult: Bool
    let backdrop_path: String
    let overview: String
    let original_language: String
    let release_date: String
    let original_title: String
    let vote_average: Double
}
