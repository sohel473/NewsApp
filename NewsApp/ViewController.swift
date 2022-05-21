//
//  ViewController.swift
//  NewsApp
//
//  Created by Abdullah Al Sohel on 5/20/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        
        fetchData()
    }

    func fetchData() {
        APICaller.shared.getNews()
    }

}

