//
//  ModalViewController.swift
//  Test UD
//
//  Created by Олег Савельев on 06.07.2021.
//

import UIKit

class ModalViewController: UIViewController {
    weak var delegate: ArrayDelegate? // делегат для передачи данных из сети
    var dataFetcher = DataFetcherService() //внедрение зависимостей
    
    //MARK: - Initializing variables and UIElements
    var moviesArray = [MovieData]()

    @IBOutlet weak var viewModal: UIView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var quantityTextfield: UITextField!
    @IBOutlet weak var searchBttn: UIButton!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -(viewModal.frame.size.height + 30)
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    // MARK: - Search data
    @IBAction func searchButton(_ sender: UIButton) {
        guard let title = titleTextfield.text,
              let quantity = quantityTextfield.text else { return }
        
        dataFetcher.fetchMovie(title: title, quantity: quantity, completion: { [weak self] movies in
            guard let self = self else { return }
            guard let movies = movies else { return }
            for item in movies.search {
                guard let movie = MovieData(data: item) else { return }
                self.moviesArray.append(movie)
            }
            if movies.response != "True" {
                print("Incorrect data entered")
            }
            self.delegate?.update(array: self.moviesArray)
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    //MARK: - Update View
    func setupView(){
        viewModal.layer.cornerRadius = 20
        titleTextfield.layer.cornerRadius = 8
        quantityTextfield.layer.cornerRadius = 8
        searchBttn.layer.cornerRadius = 8
    }
    // Dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
