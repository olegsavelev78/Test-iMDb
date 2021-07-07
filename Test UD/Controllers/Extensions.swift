//
//  Extensions.swift
//  Test UD
//
//  Created by Олег Савельев on 07.07.2021.
//

import Foundation

protocol ArrayDelegate: AnyObject {
    func update(array: [MovieData])
}

extension ViewController: ArrayDelegate {
    //MARK: - Обновление таблицы с помощью делегата
    func update(array: [MovieData]) {
        self.moviesArray = array
        tableView.isHidden = false
        nameLabel.isHidden = true
        tableView.reloadData()
    }
}
