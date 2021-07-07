//
//  NetworkDataFetcher.swift
//  Test UD
//
//  Created by Олег Савельев on 05.07.2021.
//

import Foundation

class NetworkDataFetcher {
    
    private var network: Network //внедрение зависимостей
    
    init(network: Network = Network()) {
        self.network = network
    }
    // Parsing JSON
    func fetchJSONData(urlString: String, response: @escaping (SearchData?) -> Void) {
        network.request(urlString: urlString) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(data: data)
            response(decoded)
        }
    }
    
    // Decode JSON
    private func decodeJSON(data: Data?) -> SearchData? {
        let decoder = JSONDecoder()
        guard let data = data else {
            return nil
        }
        do {
            let objects = try decoder.decode(SearchData.self, from: data)
            return objects
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
