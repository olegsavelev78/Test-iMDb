//
//  DetailViewController.swift
//  Test UD
//
//  Created by Олег Савельев on 05.07.2021.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Initializing variables and UIElements
    var movie: MovieData?
        
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var iMDbButton: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentTextfield: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(item: movie)
        self.navigationItem.title = movie?.name
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -220
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    //MARK: - Update View
    func updateView(item: MovieData?){
        guard let item = item else { return }
        if let url = item.poster {
            loadImage(urlString: url)
        }
        self.titleLabel.text = item.name
        self.yearLabel.text = item.year
        
        self.commentButton.layer.cornerRadius = 15
        self.commentTextfield.layer.cornerRadius = 15
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
    
    @IBAction func likeTapped(_ sender: UIButton){
        guard var like = movie?.like else { return }
        like = !like
        like ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        print(like)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Navigation
    @IBAction func goToWeb(_ sender: UIButton) {
        let webVC = storyboard?.instantiateViewController(identifier: "WebVC") as! WebViewController
        webVC.movie = movie
        self.navigationController?.pushViewController(webVC, animated: true)
    }
}
