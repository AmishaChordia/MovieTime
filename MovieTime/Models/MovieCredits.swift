//
//  MovieCredits.swift
//  MovieTime
//
//  Created by Chordia, Amisha on 28/02/20.
//  Copyright © 2020 Amisha. All rights reserved.
//

struct MovieCredits: Codable {
    let id: Int
    let cast: [MovieCast]
}

struct MovieCast: Codable {
    let name: String
    let character: String
}
