//
//  DataFetcherService.swift
//  Test UD
//
//  Created by Олег Савельев on 05.07.2021.
//

import Foundation

class DataFetcherService {
    
    private let apiKey = "e090ea93"
    
    private var networkDataFetcher: NetworkDataFetcher //внедрение зависимостей
    
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchMovie(title: String, quantity: String, completion: @escaping (SearchData?) -> Void) {
        let urlString = "https://www.omdbapi.com/?apiKey=\(apiKey)&s=\(title)&page=\(quantity)"
        networkDataFetcher.fetchJSONData(urlString: urlString, response: completion)
    }
}
