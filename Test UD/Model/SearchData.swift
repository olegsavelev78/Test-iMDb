//
//  SearchData.swift
//  Test UD
//
//  Created by Олег Савельев on 05.07.2021.
//

import Foundation

struct SearchData: Decodable {
    let search: [Movie]
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
            case search = "Search"
            case totalResults = "totalResults"
            case response = "Response"
        }
}

struct Movie: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let poster: String

    enum CodingKeys: String, CodingKey {
            case title = "Title"
            case year = "Year"
            case imdbID = "imdbID"
            case poster = "Poster"
        }
}
