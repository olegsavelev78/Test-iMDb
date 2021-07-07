//
//  ViewController.swift
//  Test UD
//
//  Created by Олег Савельев on 05.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var dataFetcher = DataFetcherService() //внедрение зависимостей
    
    //MARK: - Initializing variables and UIElements
    var moviesArray = [MovieData]()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "OOPS NOTHING IS HERE. SET THE SEARCH PARAPMETRS"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    @IBOutlet weak var tableView: UITableView!

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if moviesArray.isEmpty { // скрытие таблицы при отсутствии данных
            tableView.isHidden = true
            view.addSubview(nameLabel)
            nameLabel.widthAnchor.constraint(equalToConstant:  200).isActive = true
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
}

//MARK: - TableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        var movie = moviesArray[indexPath.row]
        
        cell.initCell(name: movie) //инициализация ячейки, которая происходит в классе MovieTableViewCell
        cell.likeButtonAction = { //работа с лайками
            movie.like = !movie.like
            movie.like ? cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = moviesArray[indexPath.row]
        
        let detailVC = storyboard?.instantiateViewController(identifier: "DetailVC") as! DetailViewController
        detailVC.movie = movie
        self.navigationController?.pushViewController(detailVC, animated: true) //переход на экран
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Search"{
            if let destinationVC = segue.destination as? ModalViewController {
                destinationVC.delegate = self
            }
        }
    }
    
    @IBAction func show(){
        performSegue(withIdentifier: "Search", sender: nil)
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue){
    }
}


