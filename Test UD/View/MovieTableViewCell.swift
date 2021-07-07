//
//  MovieTableViewCell.swift
//  Test UD
//
//  Created by Олег Савельев on 05.07.2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var likeButtonAction : (() -> ())?
    //MARK: - Initializing variables and UIElements
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    //MARK: - Initializing Cell
    func initCell(name: MovieData){
        posterImageView.image = nil
        
        if let url = name.poster {
            loadImage(urlString: url)
        }
        titleLabel.text = name.name
        yearLabel.text = name.year
        name.like ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func loadImage(urlString: String){
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.posterImageView.image = UIImage(data: data)
            }
        }
    }
    
    //MARK: - Initializing Actions
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeButtonAction?()
    }
}
