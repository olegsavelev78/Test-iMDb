//
//  WebViewController.swift
//  Test UD
//
//  Created by Олег Савельев on 07.07.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var movie: MovieData?
    private let htmlUrl = "https://www.imdb.com/title/"

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let imdbID = movie?.imdbID else { return }
        
        guard let url = URL(string: htmlUrl + imdbID) else { return }
        
        let request = URLRequest(url: url)
        webView.load(request)
        print(url)
        
    }
}
