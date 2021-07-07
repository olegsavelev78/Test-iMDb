//
//  MovieData.swift
//  Test UD
//
//  Created by Олег Савельев on 06.07.2021.
//

import Foundation

struct MovieData {
    let name: String?
    let year: String?
    let poster: String?
    let imdbID: String?
    var like: Bool
    var comment: Int
    
    init?(data: Movie) {
        name = data.title
        year = data.year
        poster = data.poster
        imdbID = data.imdbID
        like = false
        comment = 0
    }
}
