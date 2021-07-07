//
//  Network.swift
//  Test UD
//
//  Created by Олег Савельев on 05.07.2021.
//

import Foundation

class Network {
    // Запрос данных
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        let task = createDataTask(request: request, completion: completion)
        task.resume()
    }
    // Создание URLSessionDataTask
    private func createDataTask(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data,error)
            }
        }
    }
}
